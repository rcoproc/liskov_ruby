require 'date'
require 'ostruct'

# Princípio de substituição de (L)iskov : esse princípio orienta o desenvolvedor a usar a herança 
# de uma maneira que não interrompa a lógica do aplicativo em nenhum momento. 

# Portanto, se uma classe filha chamada "XyClass" herdar de uma classe pai "AbClass", 
# a classe filha não deve replicar uma funcionalidade da classe pai de uma maneira que altere a classe pai de comportamento. 
# Portanto, você pode usar facilmente o objeto XyClass em vez do objeto AbClass sem quebrar a lógica do aplicativo

class User
  attr_accessor :email
  # attr_accessor :settings

  def initialize(email:)
    @email = email
  end

  def settings=(role:, active:, last_sign_in_at:)
    @settings = OpenStruct.new(role: role, active: active, last_sign_in_at: last_sign_in_at)
  end

  alias_method :set_settings, :settings=

  def settings
    @settings
  end
end

class AdminUser < User
  def admin?
    #@settings[0] == :admin
    settings.role == :admin
  end
end

user = User.new(email: 'ricardo@rcoproc.com')
user.set_settings(role: :user, active: true, last_sign_in_at: Date.today)

admin = AdminUser.new(email: 'rioliveira@bionexo.com')
# admin.settings = [:admin, true, Date.today]
admin.set_settings(active: true, role: :admin, last_sign_in_at: Date.today)

@users = [user, admin]

def signed_in_today?
  @users.each do |user|
    puts user.settings
    # if user.settings[:last_sign_in_at] == Date.today
    if user.settings.last_sign_in_at == Date.today
      puts "#{user.email} signed in today"
      puts "User is (admin)? #{user&.admin?}" if user.is_a? AdminUser
    end
  end
end

signed_in_today?
