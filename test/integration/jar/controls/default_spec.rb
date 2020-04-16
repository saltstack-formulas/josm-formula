# frozen_string_literal: true

title 'josm jar profile'

control 'josm jar' do
  impact 1.0
  title 'should be installed'

  describe file('/usr/local/josm-tested/josm.jar') do
    it { should exist }
  end
  describe file('/usr/local/bin/josm-osm.sh') do
    it { should exist }
  end
  describe file('/usr/local/bin/josm-ohm.sh') do
    it { should exist }
  end
end
