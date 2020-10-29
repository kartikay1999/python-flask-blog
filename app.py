from flask import Flask,render_template,request,session,redirect
from flask_sqlalchemy import SQLAlchemy
import json
from flask_mail import Mail
from datetime import datetime
import os
from werkzeug.utils import secure_filename
import math

with open('config.json','r') as c:
	params=json.load(c)['params']
local_server=True

app=Flask(__name__)
app.secret_key='super-secret-key'
app.config.update(
MAIL_SERVER='smtp.gmail.com',
MAIL_PORT='465',
MAIL_USE_SSL='True',
MAIL_USERNAME=params['gmail_user'],
MAIL_PASSWORD=params['gmail_pwd']
)
app.config['UPLOAD_FOLDER']=params['upload_location']
mail=Mail(app)

if (local_server==True):
	app.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri']
else:
	app.config['SQLALCHEMY_DATABASE_URI'] = params['prod_uri']
db=SQLAlchemy(app)

class Posts(db.Model):
	sno = db.Column(db.Integer, primary_key=True)
	title = db.Column(db.String(50), unique=False, nullable=False)
	slug=db.Column(db.String(21))
	content = db.Column(db.String(120), unique=False, nullable=False)
	date=db.Column(db.String(50))
	img_file=db.Column(db.String(12))
	tagline=db.Column(db.String(50))


class Contacts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), unique=False, nullable=False)
    phone_no=db.Column(db.String(50))
    email = db.Column(db.String(50), unique=False, nullable=False)
    msg=db.Column(db.String(50))

@app.route('/')
def home():
	#PAGINATION LOGIC
	posts=Posts.query.filter_by().all()
	last=math.ceil(len(posts)/int(params['no_of_posts']))
	#[:params['no_of_posts']]

	page=request.args.get('page')
	if(not str(page).isnumeric()):
		page=1
	page=int(page)
	posts=posts[(page-1)*int(params['no_of_posts']):(page-1)*int(params['no_of_posts'])+int(params['no_of_posts'])]

	#FIRST
	if page==1:
		prev="#"
		next='/?page='+str(page+1)
	#LAST
	elif(page==last):
		prev='/?page='+str(page-1)
		next='#'
	else:
		prev='/?page='+str(page-1)
		next='/?page='+str(page+1)

	return render_template('index.html',params=params,posts=posts,prev=prev,next=next)

@app.route('/about')
def about():
	return render_template('about.html',params=params)

@app.route('/contact',methods=['GET','POST'])
def contact():
	if (request.method=='POST'):
		name=request.form.get('name')
		email=request.form.get('email')
		msg=request.form.get('msg')
		phone=request.form.get('phone')	
		entry=Contacts(name=name,phone_no=phone,email=email,msg=msg)
		db.session.add(entry)
		db.session.commit()
		mail.send_message('Send message from '+name,
			sender=email,recipients=[params['gmail_user']],
			body=msg+phone)
	return render_template('contact.html',params=params)

@app.route('/dashboard',methods=['GET','POST'])
def dashboard():
	if('user' in session and session['user']==params['admin_user']):
		posts=Posts.query.all()
		return render_template('dashboard.html',params=params,posts=posts)
	if(request.method=='POST'):
		u_name=request.form.get('uname')
		pwd=request.form.get('pwd')
		if(u_name==params['admin_user'] and pwd==params['userpass']):
			#set the session variable
			session['user']=u_name
			posts=Posts.query.all()
			return render_template('dashboard.html',params=params,posts=posts)
	else:
		return render_template('login.html',params=params)


@app.route('/post/<string:post_slug>',methods=['GET'])
def post_route(post_slug):
	post=Posts.query.filter_by(slug=post_slug).first()

	return render_template('post.html',params=params,post=post)
@app.route('/post')
def post():
	return render_template('index.html',params=params)


@app.route('/edit/<string:sno>',methods=['GET','POST'])
def edit(sno):
	if('user' in session and session['user']==params['admin_user']):
		if(request.method=='POST'):
			box_title=request.form.get('title')
			tline=request.form.get('tline')
			slug=request.form.get('slug')
			content=request.form.get('content')
			img_file=request.form.get('img_file')
			date=datetime.now()
			if sno=='0':
				post=Posts(title=box_title,slug=slug,content=content,
					img_file=img_file,tagline=tline,date=date)
				db.session.add(post)
				db.session.commit()
			else:
				post=Posts.query.filter_by(sno=sno).first()
				post.title=request.form.get('title')
				post.tagline=request.form.get('tline')
				post.slug=request.form.get('slug')
				post.content=request.form.get('content')
				post.img_file=request.form.get('img_file')
				post.date=date
				db.session.commit()
				return redirect('/edit/'+sno)

		post=Posts.query.filter_by(sno=sno).first()
		return render_template('edit.html',params=params,post=post)


@app.route('/uploader',methods=['GET','POST'])
def uploader():
	if('user' in session and session['user']==params['admin_user']):	
		if (request.method=='POST'):
			f=request.files['datafile']
			f.save(os.path.join(app.config['UPLOAD_FOLDER'],secure_filename(f.filename)))
	return "file uploaded successfully" 
@app.route('/logout')
def logout():
	session.pop('user')
	return redirect('/dashboard')


@app.route('/delete/<string:sno>',methods=['GET','POST'])
def delete(sno):
		if('user' in session and session['user']==params['admin_user']):
			post=Posts.query.filter_by(sno=sno).first()
			db.session.delete(post)
			db.session.commit()
		return redirect('/dashboard')


app.run(debug=True)