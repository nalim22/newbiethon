class HomeController < ApplicationController
  def first
     @posts = Post.all
       
  end

  def two
    #user 정보 저장
    @users = User.new
    @users.name = params[:name]
    @users.age = params[:age]
    @users.gender = params[:gender]
    @users.location = params[:locations]
    @users.workplace = params[:workplace]
    @users.movie = params[:movie]
    @users.sports = params[:sports]
    @users.music = params[:music]
    @users.art = params[:art]
    @users.travelhow = params[:travelhow]
    
    @users.save
    
    #user 관심사
    @genre = params[:movie]
    @s_name = params[:sports]
    @m_name = params[:music]
    @a_genre = params[:art]
    
    #user가 좋아하는 영화 장르에 따라 DB에서 랜덤으로 하나를 꺼냄
    @movie_title = Movie.select(params[:movie]).sample()
    @movie_title = @movie_title["#{@genre}"]
    
    @sport_name = Sport.select(params[:sports]).sample()
    @sport_name = @sport_name["#{@s_name}"]
    
    @music_title = Music.select(params[:music]).sample()
    @music_title = @music_title["#{@m_name}"]
    
    @art_type = Art.select(params[:art]).sample()
    @art_type = @art_type["#{@a_genre}"]
    
    @travel_title = Array.new()
    
    #@route5 = params[:travelhow]
    
    old_users = User.all
    
    friends = Array.new()
    @count = 0
    
    #기존 user와 정보가 있는 user가 사는 지역이 같고 사회생활 공간이 다르면 관심사가 공통된게 있는지 확인
    old_users.each do |userArr|
      if ( @users.workplace != userArr.workplace && userArr.location == @users.location )
        if ( userArr.movie == @users.movie ||  userArr.sports == @users.sports || userArr.music == @users.music || userArr.art == @users.art || userArr.travelhow == @users.travelhow )
           friends << userArr.name
          end
        end
      end
      
    #여러 친구들 중에 한명을 뽑음
    @friend = friends.sample();
    
    my_mate = User.where(name: @friend)
   
    
    my_mate.each do |mate|
       @friend_rate = mate.rating
       
      if( @users.movie == mate.movie)
          @travel_title << @users.movie
      end
    
      if(@users.sports == mate.sports)
          @travel_title << @users.sports
      end
    
      if(@users.music == mate.music)
          @travel_title << @users.music
      end
    
      if(@users.art == mate.art)
          @travel_title << @users.art
      end
    
      if(@users.travelhow == mate.travelhow)
          @travel_title << @users.travelhow
      end
    end

  end
  
  def three
     @my_genre = params[:movie]
    
  end
  
  def three_1
    @my_sname = params[:sports]

  end
  
  def three_2
    @my_mtype = params[:music]


  end
  
  def three_3
    
    @a_genre = params[:art]
    
  
  
    

  end
  
  def four
    #입력한 이름으로 DB에서 찾음
    user_r = User.where(name: params[:name])
    user_r.each do |user|
      if ( user.rating == nil ) # 평가된 적이 없으면 rating을 입력값으로
        user.rating = params[:rating]
      else
        #이전 정보가 존재하면 평균냄
        user.rating = (user.rating + Integer(params[:rating]))/2
      end
      user.save
    end
  endㄴ
end
  