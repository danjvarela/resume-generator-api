module ResponseHelpers
  def json_body
    JSON.parse(response.body)
  end

  def format_to_response(resource, opts = {})
    serializer = "#{resource.class}Serializer".safe_constantize
    opts[:each_serializer] = serializer if resource.is_a? Array
    opts[:root] ||= "data"
    JSON.parse(
      ActiveModelSerializers::SerializableResource.new(resource, opts).to_json
    )
  end
end
