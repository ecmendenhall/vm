seconds_in_a_day = 86400

execute "apt-get-update-periodic" do
  command "apt-get update"
  ignore_failure true
  not_if do
    File.exists?('/var/lib/apt/periodic/update-success-stamp') &&
      File.mtime('/var/lib/apt/periodic/update-success-stamp') > Time.now - seconds_in_a_day
  end
end

package "build-essential"
package "ruby1.9.1-dev" # for chef
package "zip" # so we can look inside jarfiles
package "libmagickwand-dev"
package "imagemagick"
