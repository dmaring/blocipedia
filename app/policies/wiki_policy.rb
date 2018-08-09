class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    @user.present?
  end

  def new?
    create?
  end

  def update?
    @user.present?
  end

  def edit?
    @user.admin? || @wiki.user_id == @user.id || @wiki.private == false
  end

  def destroy?
    edit?
  end



  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
