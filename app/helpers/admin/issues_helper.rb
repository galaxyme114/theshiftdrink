module Admin::IssuesHelper
  def thumbnail_for(issue)
    front_page = issue.front_page
    
    if front_page.nil?
      image_tag 'https://s3-us-west-2.amazonaws.com/shiftdrink/static/default/issue-cover.jpg'
    else
      image_tag front_page.image_url(:large)
    end
  end

  def issue_numbers
    (1..50).map {|n| ["%03d" % n, "%03d" % n] }
  end

  def issue_count
    "%03d" % ( Issue.publications.count + 1 )
  end
end