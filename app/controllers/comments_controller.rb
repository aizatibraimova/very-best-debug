class CommentsController < ApplicationController
  def create

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
