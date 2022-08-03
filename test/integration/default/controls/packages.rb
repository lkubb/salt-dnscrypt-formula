# frozen_string_literal: true

control 'dnscrypt.package.install' do
  title 'The required package should be installed'

  package_name = 'dnscrypt-proxy'

  describe package(package_name) do
    it { should be_installed }
  end
end
