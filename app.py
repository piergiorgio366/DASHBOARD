
from flask import Flask, render_template, request, redirect, session
import json
from pathlib import Path

app = Flask(__name__)
app.secret_key = 'supersecretkey'

USERS_FILE = Path("data/users.json")

@app.route("/", methods=["GET"])
def home():
    if "user" in session:
        return redirect("/dashboard")
    return redirect("/login")

@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        with open(USERS_FILE) as f:
            users = json.load(f)
        username = request.form["username"]
        password = request.form["password"]
        if username in users and users[username]["password"] == password:
            session["user"] = username
            session["role"] = users[username]["role"]
            return redirect("/dashboard")
        else:
            return "Credenziali errate", 403
    return render_template("login.html")

@app.route("/dashboard")
def dashboard():
    if "user" not in session:
        return redirect("/login")
    role = session.get("role", "")
    if role == "editor":
        return render_template("dashboard.html", editable=True)
    elif role == "viewer":
        return render_template("dashboard.html", editable=False)
    return "Accesso non autorizzato", 403

@app.route("/logout")
def logout():
    session.pop("user", None)
    session.pop("role", None)
    return redirect("/login")

if __name__ == "__main__":
    app.run(debug=True)
