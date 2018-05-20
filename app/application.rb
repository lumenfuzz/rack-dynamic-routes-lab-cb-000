class Application
  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      search_term = req.path.split("/items/").last
      @@items.each do |item|
        search_term = item if item.name == search_term
      end
      if (search_term.is_a? Item)
        resp.write "The item #{search_term.name} costs #{search-term.price}"
        resp.status = 200
      else
        resp.write "Item not found"
        resp.status = 400
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end

=begin
elsif req.path.match(/search/)
  search_term = req.params["q"]
  resp.write handle_search(search_term)
=end
