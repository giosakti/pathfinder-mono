class Deployment < ApplicationRecord
  validates :name,
    presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: HOSTNAME_FORMAT },
    length: { minimum: 1, maximum: 255 }

  validates :desired_num_replicas,
    numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 99 }
  validates :min_available_replicas,
    numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 99 }

  belongs_to :cluster

  def container_names
    (0..desired_num_replicas-1).map{ |i| "#{name}-%02d" % (i+1) }
  end

  # will be deprecated in the near future
  def managed_containers
    Container.exists.
      where("hostname ~* ?", managed_containers_hostname_regexp).
      where(cluster: cluster)
  end

  def desired_replicas
    Container.exists.
      where(hostname: container_names).
      where(cluster: cluster)
  end

  private
  def managed_containers_hostname_regexp
    "^#{Regexp.escape(name)}-[0-9]{2}$"
  end
end
