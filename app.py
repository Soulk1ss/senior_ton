from flask import Flask, render_template, request, jsonify, make_response, send_from_directory, redirect, url_for
import jwt
import datetime
import json
from functools import wraps
from flask_mysqldb import MySQL
from datetime import datetime
import os

now = datetime.now()
app = Flask(__name__, template_folder='templates')
app.secret_key = "awdawdawdasdwad"
app.config["MYSQL_USER"] = 'root'
app.config["MYSQL_DB"] = 'senior_database'
mysql = MySQL(app)

def requireToken(f):
  @wraps(f)
  def decorated():
    try:
      token = request.headers["Authorization"]       
      try:
        data = jwt.decode(token, app.secret_key, algorithms=["HS256"])
      except:
        return jsonify({"message": "invalid token"}), 403
    except:
      return jsonify({"message": "token missing"}), 403
    return f(data["user_id"])
  return decorated

def login_required(f):
    @wraps(f)
    def secure_function(): 
      try:
        request.headers["Authorization"]
      except:       
        return redirect('/login')      
      return f()
    return secure_function

@app.route('/')
@app.route('/login', methods = ["GET", "POST"])
def login():
  if (request.method == "GET"):
    return render_template('login.html')
  else:    
    data = request.json
    if data["username"] and data["password"]:      
      cur = mysql.connection.cursor()
      sql = "SELECT * FROM tb_admin WHERE ad_username = %s and ad_password = %s"
      cur.execute(sql, (data["username"], data["password"]))
      row_headers=[x[0] for x in cur.description]
      data = cur.fetchall()
      if len(data) == 0:
        return make_response("username or password incorrect", 404)
      else:
        json_data=[]   
        for result in data:
          json_data.append(dict(zip(row_headers,result)))   
        cur.close()      
        token = jwt.encode({"user_id": json_data[0]["ad_id"], "username": json_data[0]["ad_username"]}, app.config["SECRET_KEY"], algorithm="HS256")
        return token
    return make_response("username and password is null", 401)

@app.route('/reset_password', methods = ["POST"])
@requireToken
def reset_password(user_id):  
  req = request.json
  if not req:
    return make_response("data is null", 403)
  else:
    sql = "SELECT ad_password FROM tb_admin WHERE ad_id = %s"
    cur = mysql.connection.cursor()
    cur.execute(sql, [str(user_id)])
    data = cur.fetchall()
    row_headers=[x[0] for x in cur.description]
    data_json = convert_tuple_toJSON(row_headers, data)
    if data_json[0]["ad_password"] == req["current_password"]:
      sql = "UPDATE tb_admin SET ad_password = %s WHERE ad_id = %s"
      cur.execute(sql, (req["new_password"], str(user_id)))
      mysql.connection.commit()      
      return make_response("success", 200)
    else:
      return make_response("password incorrect", 404)
    
@app.route('/dashboard', methods= ["GET"])
@requireToken
def dashboard(user_id):
  formatted_date = now.strftime('%Y-%m-%d')
  sql = "SELECT * FROM tb_topkeyword WHERE k_date = %s"
  cur = mysql.connection.cursor()
  cur.execute(sql, [formatted_date])
  data = cur.fetchall()
  row_headers=[x[0] for x in cur.description]
  data_json = convert_tuple_toJSON(row_headers, data)
  return jsonify(data_json)

@app.route('/list_dowload', methods = ["GET"])
@requireToken
def list_dowloadn(user_id):
  sql = "SELECT * FROM tb_data"
  cur = mysql.connection.cursor()
  cur.execute(sql)
  data = cur.fetchall()
  row_headers=[x[0] for x in cur.description]
  data_json = convert_tuple_toJSON(row_headers, data)
  return jsonify(data_json)

@app.route('/download/<filename>', methods=['GET'])
def downloadFile_t(filename):
    path = os.path.join(app.root_path, 'downloadFile')
    download = send_from_directory(path, filename)
    return download

@app.route('/home')
@login_required
def home():  
  return render_template('dashboard.html')

@app.route('/changepassword')
@login_required
def changepasswordPage():
    return render_template('changepassword.html')

def convert_tuple_toJSON(header, data):
  json_data=[]   
  for result in data:
    json_data.append(dict(zip(header,result))) 
  return json_data


if __name__ == '__main__':
  app.debug = True
  app.run(host='0.0.0.0', port=8000)