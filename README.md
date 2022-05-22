# Blog posts API

Prerequisite:

    - Ruby - 3.1.2p20
    - Rails - 7.0.3
    - Database: postgresql

Step to run application:

    - Clone the repo
    - rails db:setup
    - rails db:migrate
    - rails db:seed
    - rails s

# Questions

    1. Find the Post with Max Comments
    
        Post.joins(:comments).select("posts.id as post_id, posts.title, COUNT(comments.id) as comments_count").group('posts.id')


        select p.id as post_id, p.title as title, count(c.id) as comments_count from posts p
            join comments c
            ON p.id = c.post_id
            group by p.id
            order by comments_count;
            
    2. Find the Users who has commented most
    
        Comment.select("user_id, COUNT(user_id) as comments_count").order("comments_count desc").group(:user_id)	

        select user_id, COUNT(user_id) as comments_count from comments group by user_id order by comments_count desc
        
        
