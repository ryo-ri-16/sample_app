require 'ostruct'

Shindo.tests('Fog::Compute[:vsphere] | get_network request', ['vsphere']) do
  compute = Fog::Compute[:vsphere]

  before do
    mocha_setup
  end
  after do
    mocha_teardown
  end

  def make_fake_dvs(args = {})
    config = OpenStruct.new(
      distributedVirtualSwitch: OpenStruct.new(name: args[:dvs_name])
    )
    network = stub(args.merge(config: config))
    network.expects('is_a?')
           .with(RbVmomi::VIM::DistributedVirtualPortgroup)
           .returns(true)
    network
  end

  def fake_networks
    [
      OpenStruct.new(_ref: 'network-1', name: 'non-dvs'),
      make_fake_dvs(_ref: 'network-2', name: 'web1', dvs_name: 'dvs5', key: '4001'),
      make_fake_dvs(_ref: 'network-3', name: 'web1', dvs_name: 'dvs11', key: '4001'),
      make_fake_dvs(_ref: 'network-4', name: 'other', dvs_name: 'other', key: '4001')
    ]
  end

  tests('#choose_finder should') do
    test('choose the network based on network name and dvs name') do
      finder = compute.send(:choose_finder, 'web1', 'dvs11')
      found_network = fake_networks.find { |n| finder.call(n) }
      found_network.name == 'web1' && found_network.dvs_name == 'dvs11'
    end
    test('choose the network based on network name and any dvs') do
      finder = compute.send(:choose_finder, 'web1', :dvs)
      found_network = fake_networks.find { |n| finder.call(n) }
      found_network.name == 'web1' && found_network.dvs_name == 'dvs5'
    end
    test('choose the network based on network name only') do
      finder = compute.send(:choose_finder, 'other', nil)
      found_network = fake_networks.find { |n| finder.call(n) }
      found_network.name == 'other' && found_network.dvs_name == 'other'
    end
    test('choose the network based on network name only for non-dvs') do
      finder = compute.send(:choose_finder, 'non-dvs', nil)
      found_network = fake_networks.find { |n| finder.call(n) }
      found_network.name == 'non-dvs' && found_network.class.name.to_s == 'OpenStruct'
    end
  end
end

require_relative '../../test_helper'

describe Fog::Vsphere::Compute::Real do
  include Fog::Vsphere::TestHelper

  before { Fog.unmock! }
  after { Fog.mock! }

  let(:compute) { prepare_compute }

  describe '#get_network' do
    it 'gets network by name or ref' do
      with_webmock_cassette('get_network') do
        network = compute.get_network('InternalNetwork', 'BRQ')
        assert_equal(network[:name], 'InternalNetwork')

        network = compute.get_network('network-12', 'BRQ')
        assert_equal(network[:id], 'network-12')
      end
    end
  end
end
