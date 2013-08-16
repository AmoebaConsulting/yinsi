class BaseModel
  def self.http_query(url,&block)
    builder = HttpBuilder.new
    block.call(builder)
    builder.build(url)
  end

  def http_query(url, &block)
    self.class.http_query(url, &block)
  end
end