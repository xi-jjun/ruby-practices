# README

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



## Reference

[generating model - rails official guide](https://guides.rubyonrails.org/getting_started.html#mvc-and-you-generating-a-model)

[database migration - rails official guide](https://guides.rubyonrails.org/getting_started.html#database-migrations)

