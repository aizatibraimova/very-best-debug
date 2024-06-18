class VenuesController < ApplicationController

  def index
    matching_venues = Venue.all
    @venues = matching_venues.order(:created_at)

    render({ :template => "venue_templates/venue_list" })
  end

  def show
    venue_id = params.fetch("venue_id")
    matching_venues = Venue.where({ :id => venue_id })
    @the_venue = matching_venues.at(0)

    render({ :template => "venue_templates/details" })
  end

  def create

    input_address = params.fetch("query_address")
    input_name = params.fetch("query_name")
    input_neighborhood = params.fetch("query_neighborhood")

    venue = Venue.new

   venue.address = input_address
    venue.name = input_name
    venue.neighborhood = input_neighborhood

    venue.save

    redirect_to("/venues/#{venue.id}")

  end
  
  def update
    the_id = params.fetch("the_id")
    matching_venues = Venue.where({ :id => the_id })
    the_venue = matching_venues.at(0)

    venue_address = params.fetch("query_address")
    venue_name = params.fetch("query_name")
    venue_neighborhood = params.fetch("query_neighborhood")

    the_venue.address = venue_address 
    the_venue.name = venue_name
    the_venue.neighborhood = venue_neighborhood

  
    the_venue.save
    
    redirect_to("/venues/#{the_venue.id}")
  end

  def destroy
    the_id = params.fetch("path_id")
    matching_venues = Venue.where({ :id => the_id })
    the_venue = matching_venues.at(0)
    the_venue.destroy

    redirect_to("/venues")
  end

  def add_comment

    comment_author_id = params.fetch("query_author_id")
    comment_venue_id = params.fetch("query_venue_id")
    comment_body = params.fetch("query_body")

    new_comment = Comment.new

    new_comment.author_id = comment_author_id
    new_comment.venue_id = comment_venue_id
    new_comment.body = comment_body
 
    new_comment.save
    
    matching_venues = Venue.where({ :id => new_comment.venue_id })
    the_venue = matching_venues.at(0)
    
    redirect_to("/venues/#{new_comment.venue_id}")
  end

end
