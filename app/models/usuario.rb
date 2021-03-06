class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :nome

  attr_accessor :nome

  has_one :perfil

  validates :papel, inclusion: { in: %w(super-administrador administrador moderador usuario) }

  before_validation :define_papel_padrao

  def after_initialize
    self.perfil ||= build_perfil
  end

  def before_save
    self.perfil.nome = self.nome
  end

  private
  def define_papel_padrao
    self.papel ||= 'usuario'
  end
end
