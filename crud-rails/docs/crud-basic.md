# CRUD basic

## Generating Model - [link](https://guides.rubyonrails.org/getting_started.html#mvc-and-you-generating-a-model)

```shell
rails generate model MODEL_NAME [attributes]
```

```shell
rails g model member name age:integer description:text
```

그리고 db migrate로 실제 테이블에 반영해준다.

```shell
rails db:migrate
```

```ruby
# 20221204050237_create_members.rb 생성된다.
class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members do |t|
      t.string :name
      t.integer :age
      t.text :description

      t.timestamps
    end
  end
end
```

> *Migrations* are used to alter the structure of an application's database. In Rails applications, migrations are written in Ruby so that they can be database-agnostic.

`Migration`은 데이터베이스 구조를 바꾸기 위해 사용되고, Rails에서 `migration`은 `Ruby`로 작성됐기에 database에 의존적이지 않다. 자세한 것은 [여기서](https://guides.rubyonrails.org/getting_started.html#database-migrations) 더 찾아보면 된다.

<br>

## POST-/members

`member`회원 한 명을 추가하는 연습.

```shell
rails g controller member
```

`member controller` 추가.

```ruby
class MemberController < ApplicationController
  def create
    member = Member.create(name: params[:name], age: params[:age], description: params[:description])
    member.save

    render json: { "message" => "success to save" }
  end
end
```

```ruby
Rails.application.routes.draw do
  post '/members' => 'member#create'
end
```

`routes.rb` file에 관련 api url mapping.

그러나 POST request에 대해 다음과 같은 오류 발생

```shell
...
ActionController::InvalidAuthenticityToken (Can't verify CSRF token authenticity.):
...
```

[stackoverflow](https://stackoverflow.com/questions/35181340/rails-cant-verify-csrf-token-authenticity-when-making-a-post-request)에서 이러한 질문이 있었고 해결.

```ruby
# application_controller.rb
class ApplicationController < ActionController::API
end
```

`application_controller.rb` file에서 `ActionController::Base` → `ActionController::API`로 변경하여 해결.

<br>

## GET-/members/1

이미 존재하던 데이터.(아까 위에서 보냈던 post request)

```json
{
    "name" : "kim jae jun",
    "description" : "안녕하세요 저는 김재준이라고 합니다. ~~~~~~~~~~very very long self introduction",
    "age" : 26
}
```

member controller에 get 관련 기능 추가, `routes.rb`에 라우팅.

```ruby
Rails.application.routes.draw do
  get '/members/:id' => 'member#show'
  post '/members' => 'member#create'
end
```

```ruby
class MemberController < ApplicationController
  def show
    member = Member.find(params[:id])
    render json: member
  end

  def create
    ...
  end
end
```

`GET-/members/1`결과

```json
{
    "id": 1,
    "name": "kim jae jun",
    "age": 26,
    "description": "안녕하세요 저는 김재준이라고 합니다. ~~~~~~~~~~very very long self introduction",
    "created_at": "2022-12-04T05:36:04.215Z",
    "updated_at": "2022-12-04T05:36:04.215Z"
}
```

<br>

## PATCH-/members/1

`routes.rb`에 patch url request 매핑 해주고, `member_controller.rb`에 관련 기능 추가.

```ruby
Rails.application.routes.draw do
  get '/members/:id' => 'member#show'
  post '/members' => 'member#create'
  patch '/members/:id' => 'member#update'
end
```

```ruby
class MemberController < ApplicationController
  def show
    ...
  end

  def create
    ...
  end

  def update
    member = Member.find(params[:id])
    member.name = params[:name]
    member.age = params[:age]
    member.description = params[:description]

    member.save

    render json: { "message" => "success to update member id=#{params[:id]}" }
  end
end
```

`update` method를 추가.

<br>

## DELETE-/members/1

```ruby
Rails.application.routes.draw do
  get '/members/:id' => 'member#show'
  post '/members' => 'member#create'
  patch '/members/:id' => 'member#update'
  delete '/members/:id' => 'member#delete'
end
```

```ruby
class MemberController < ApplicationController
  def show
    ...
  end

  def create
    ...
  end

  def update
    ...
  end

  def delete
    member = Member.find(params[:id])
    member.delete

    render json: { "message" => "success to remove member id=#{params[:id]}" }
  end
end

```

<br>



## Reference

[generating model - rails official guide](https://guides.rubyonrails.org/getting_started.html#mvc-and-you-generating-a-model)

[database migration - rails official guide](https://guides.rubyonrails.org/getting_started.html#database-migrations)

[rails CSRF problem - stackoverflow](https://stackoverflow.com/questions/35181340/rails-cant-verify-csrf-token-authenticity-when-making-a-post-request)

