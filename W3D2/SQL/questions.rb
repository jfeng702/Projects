require 'sqlite3'
require 'singleton'

#%$%^%^*&^%&^%&^%*%&^%*%*&^*&^%*^*&^*&^*^*&^*&^*^*&^*&
class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

#%$%^%^*&^%&^%&^%*%&^%*%*&^*&^%*^*&^*&^*^*&^*&^*^*&^*&
#%$%^%^*&^%&^%&^%*%&^%*%*&^*&^%*^*&^*&^*^*&^*&^*^*&^*&
#%$%^%^*&^%&^%&^%*%&^%*%*&^*&^%*^*&^*&^*^*&^*&^*^*&^*&
class Question
  attr_accessor :title, :body, :author_id

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
    data.map { |datum| Question.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end

  def self.find_by_author_id(author_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, author_id)
    SELECT
      *
    FROM
      questions
    WHERE
      author_id=?
    SQL
    return nil unless questions.length > 0

    questions.map{|question| Question.new(question)}
  end


  def self.find_by_id(id)
    question = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      questions
    WHERE
      id=?
    SQL
    return nil unless question.length > 0

    return Question.new(question.first)
  end

  def create
    raise "#{self} already in database" if @id
    QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @author_id)
      INSERT INTO
        questions(title, body, author_id)
      VALUES
        (?, ?, ?)
    SQL
    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @author_id, @id)
      UPDATE
        questions
      SET
        title = ?, body = ?, author_id = ?
      WHERE
        id = ?
    SQL
  end

  def author
    user = QuestionsDatabase.instance.execute(<<-SQL, @author_id)
    SELECT
      *
    FROM
      users
    WHERE
      id = ?
    SQL

    User.new(user.first)
  end

  def replies
    Reply.find_by_question_id(@id)
  end
end
#%$%^%^*&^%&^%&^%*%&^%*%*&^*&^%*^*&^*&^*^*&^*&^*^*&^*&*^*&^*&^*^*&^*&
#%$%^%^*&^%&^%&^%*%&^%*%*&^*&^%*^*&^*&^*^*&^*&^*^*&^*&*^*&^*&^*^*&^*&
#%$%^%^*&^%&^%&^%*%&^%*%*&^*&^%*^*&^*&^*^*&^*&^*^*&^*&*^*&^*&^*^*&^*&
class User
  attr_accessor :fname, :lname

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM users")
    data.map { |datum| User.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def self.find_by_id(id)
    user = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      users
    WHERE
      id=?
    SQL
    return nil unless user.length > 0

    return User.new(user.first)
  end

  def authored_replies

    Reply.find_by_user_id(@id)
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def self.find_by_name(fname, lname)
    user = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
    SELECT
      *
    FROM
      users
    WHERE
      fname=? AND lname=?
    SQL
    return nil unless user.length > 0

    return User.new(user.first)
  end
end
#%$%^%^*&^%&^%&^%*%&^%*%*&^*&^%*^*&^*&^*^*&^*&^*^*&^*&*^*&^*&^*^*&^*&
#%$%^%^*&^%&^%&^%*%&^%*%*&^*&^%*^*&^*&^*^*&^*&^*^*&^*&*^*&^*&^*^*&^*&
#%$%^%^*&^%&^%&^%*%&^%*%*&^*&^%*^*&^*&^*^*&^*&^*^*&^*&*^*&^*&^*^*&^*&
class Question_Follow
  attr_accessor :question_id, :user_id

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM question_follows")
    data.map { |datum| Question_Follow.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end

  def self.find_by_id(id)
    question_follow = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      question_follows
    WHERE
      id=?
    SQL
    return nil unless question_follow.length > 0

    return Question_Follow.new(question_follow.first)
  end
end
#%$%^%^*&^%&^%&^%*%&^%*%*&^*&^%*^*&^*&^*^*&^*&^*^*&^*&*^*&^*&^*^*&^*&
#%$%^%^*&^%&^%&^%*%&^%*%*&^*&^%*^*&^*&^*^*&^*&^*^*&^*&*^*&^*&^*^*&^*&
#%$%^%^*&^%&^%&^%*%&^%*%*&^*&^%*^*&^*&^*^*&^*&^*^*&^*&*^*&^*&^*^*&^*&
class Reply
  attr_accessor :question_id, :parent_id, :user_id, :body

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
    data.map { |datum| Reply.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @parent_id = options['parent_id']
    @user_id = options['user_id']
    @body = options['body']
  end

  def self.find_by_id(id)
    reply = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      replies
    WHERE
      id=?
    SQL
    return nil unless reply.length > 0

    return Reply.new(reply.first)
  end

  def self.find_by_user_id(user_id)
    reply = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      *
    FROM
      replies
    WHERE
      user_id=?
    SQL
    return nil unless reply.length > 0

    return Reply.new(reply.first)
  end

  def self.find_by_question_id(question_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      *
    FROM
      replies
    WHERE
      question_id=?
    SQL
    return nil unless replies.length > 0

    replies.map{|reply| Reply.new(reply)}
  end

  def author
    user = QuestionsDatabase.instance.execute(<<-SQL, @user_id)
    SELECT
      *
    FROM
      users
    WHERE
      id=?
    SQL

    User.new(user.first)
  end

  def question
    question = QuestionsDatabase.instance.execute(<<-SQL, @question_id)
    SELECT
      *
    FROM
      questions
    WHERE
      id=?
    SQL

    Question.new(question.first)
  end

  def parent_reply
    raise "There is no parent reply" unless @parent_id
    parent_reply = QuestionsDatabase.instance.execute(<<-SQL, @parent_id)
    SELECT
      *
    FROM
      replies
    WHERE
      id=?
    SQL
    return nil unless parent_reply.length > 0

    Reply.new(parent_reply.first)
  end

  def child_replies
    # raise "There is no parent reply" unless @parent_id
    child_replies = QuestionsDatabase.instance.execute(<<-SQL, @id)
    SELECT
      *
    FROM
      replies
    WHERE
      parent_id=?
    SQL
    return nil unless child_replies.length > 0

    child_replies.map{|child_reply| Reply.new(child_reply)}
  end
end
#%$%^%^*&^%&^%&^%*%&^%*%*&^*&^%*^*&^*&^*^*&^*&^*^*&^*&*^*&^*&^*^*&^*&
#%$%^%^*&^%&^%&^%*%&^%*%*&^*&^%*^*&^*&^*^*&^*&^*^*&^*&*^*&^*&^*^*&^*&
#%$%^%^*&^%&^%&^%*%&^%*%*&^*&^%*^*&^*&^*^*&^*&^*^*&^*&*^*&^*&^*^*&^*&
class Question_Like
  attr_accessor :question_id, :user_id

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM question_likes")
    data.map { |datum| Question_Like.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end

  def self.find_by_id(id)
    question_like = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      question_likes
    WHERE
      id=?
    SQL
    return nil unless question_like.length > 0

    return Question_Like.new(question_like.first)
  end
end

user = User.all.first
question = Question.new({'title'=> 'What is Javascript?', 'author_id' => 2, 'body' => 'is Javascript a functional programming language?'})
question.create
question1=Question.all.first
reply = Reply.all.first
reply1 = Reply.new({'question_id'=>0, 'parent_id'=>3, 'user_id'=>0, 'body'=>'Please work :)'})
p "1 #{Question.find_by_author_id(1)}"
p "2 #{Reply.find_by_user_id(1)}"
p "3 #{Reply.find_by_question_id(1)}"
p "4 #{User.find_by_name('Joey', 'Feng')}"
p "5 #{user.authored_questions}"
p "6 #{user.authored_replies}"
p "7 #{question.author}"

p "8 #{question1.replies}"

p "9 #{reply.author}"
p "10 #{reply.question}"
p "11 #{reply1.parent_reply}"
p "12 #{reply.child_replies}"
