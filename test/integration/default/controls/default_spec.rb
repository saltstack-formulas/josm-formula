# frozen_string_literal: true

title 'josm archives profile'

control 'josm binary archive' do
  impact 1.0
  title 'should be installed'

  describe file('/usr/local/josm-3.19.1.1/josm.jar') do
    it { should exist }
  end
  describe file('/usr/local/bin/josm.sh') do
    it { should exist }
  end
end
