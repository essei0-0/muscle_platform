FactoryBot.define do
  factory :user do
    id {1}
    name {'test'}
    email {'test@test.com'}
    password {'password'}

    factory :user_name_blank do
      name {''}
    end

    factory :user_name_nil do
      name {nil}
    end

    factory :user_name_more_than_50 do
      name {'a' * 51}
    end

    factory :user_email_blank do
      email {''}
    end

    factory :user_email_nil do
      email {nil}
    end

    factory :user_email_more_than_255 do
      email {'a' * 255 + '@test.com'}
    end

    factory :user_password_blank do
      password {' ' * 6}
    end

    factory :user_password_nil do
      password {nil}
    end

    factory :user_password_less_than_6 do
      password {'pass'}
    end
  end
end
