### Hexlet tests and linter status:
[![Actions Status](https://github.com/mikhailkaryamin/rails-project-63/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/mikhailkaryamin/rails-project-63/actions)

## Пример использования

```ruby
User = Struct.new(:name, :job, :gender, keyword_init: true)
user = User.new name: 'rob', job: 'hexlet', gender: 'm'

HexletCode.form_for user do |f|
  # Проверяет есть ли значение внутри name
  f.input :name, class: 'user-input'
  # Проверяет есть ли значение внутри job
  f.input :job, as: :text, rows: 50, cols: 50
end
```
Возвращает без переноса строк, но для примера они указаны

TODO: Добавить перенос строк
```html
<form action="#" method="post">
  <input name="name" type="text" value="Rob" class="user-input"/>
  <textarea rows="50" cols="50" name="job" type="text"/>
</form>
```

Если указанного поля нет в объекте, то возникает ошибка

```ruby
HexletCode.form_for user, url: '/users' do |f|
  f.input :name
  f.input :job, as: :text
  # Поля age у пользователя нет
  f.input :age
end
# =>  `public_send': undefined method `age' for #<struct User id=nil, name=nil, job=nil> (NoMethodError)
```