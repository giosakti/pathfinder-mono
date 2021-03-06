class ::Api::V2::Node::ContainerSerializer < ::Api::V2::BaseSerializer
  def data
    if @object.is_a? Enumerable
      {
        total_server_items: @total_server_items,
        items: @object.map{ |container| serialize(container) }
      }
    else
      serialize(@object)
    end
  end

  def serialize(container)
    {
      id: container.id,
      hostname: container.hostname,
      ipaddress: container.ipaddress,
      source: {
        id: container.source&.id,
        # TODO: need to create adapter for different type of agent
        source_type: container.source&.source_type,
        mode: container.source&.mode,
        remote: {
          id: container.source&.remote&.id,
          name: container.source&.remote&.name,
          server: container.source&.remote&.server,
          protocol: container.source&.remote&.protocol,
          auth_type: container.source&.remote&.auth_type,
          certificate: container.source&.remote&.certificate
        },
        fingerprint: container.source&.fingerprint,
        alias: container.source&.alias
      },
      bootstrappers: container.bootstrappers,
      node_hostname: (container.node&.hostname || ""),
      status: container.status,
      last_status_update_at: container.last_status_update_at,
    }
  end
end
