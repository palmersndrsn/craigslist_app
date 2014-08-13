# scrapper.rb
require 'nokogiri'
require 'open-uri'
require 'awesome_print'
#why does this need to be in this order? I put search on the
#top and it wouldn't work.
def filter_img(dogs)
  with_img = dogs.select do |results|
    results.css(".p")
  end
end

def filter_links(list)
  dogs_found = list.select do |results|
    results.text.match(/dog|Dog|pup|Pup|puppies|Puppies/)
  end
  filter_img(dogs_found)
end

def get_todays_rows(doc, date_str)
  list = doc.css(".row").select do |results|
    results.css(".date").text == date_str
  end
  filter_links(list)
end

def get_page_results(date_str)
  url = open("today.html").read
  page = Nokogiri::HTML(url)
  get_todays_rows(page,date_str)
end

def search(date_str)
  get_page_results(date_str)
end

today = "Aug 12" #Time.now.strftime("%b %d")
ap search(today)