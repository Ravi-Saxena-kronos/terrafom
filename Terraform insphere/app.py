import os
import subprocess
from flask import Flask, render_template, request, redirect, flash

app = Flask(__name__)
app.secret_key = "supersecretkey"

TERRAFORM_DIR = "./Terraform"

@app.route("/", methods=["GET", "POST"])
def index():
    if request.method == "POST":
        access_key = request.form["access_key"]
        secret_key = request.form["secret_key"]
        bucket_name = request.form["bucket_name"]
        region = request.form["region"]
        action = request.form["action"]

        # Set environment variables for Terraform to use
        os.environ["AWS_ACCESS_KEY_ID"] = access_key
        os.environ["AWS_SECRET_ACCESS_KEY"] = secret_key

        backend_file = os.path.join(TERRAFORM_DIR, "backend.tf")
        with open(backend_file, "w") as f:
            f.write(f'''
terraform {{
  backend "s3" {{
    bucket = "{bucket_name}"
    key    = "terraform/state.tfstate"
    region = "{region}"
  }}
}}
''')

        try:
            os.chdir(TERRAFORM_DIR)

            subprocess.run(["terraform", "init", "-reconfigure"], check=True)

            if action == "create":
                subprocess.run([
                    "terraform", "apply", "-auto-approve",
                    "-var", f'region={region}'
                ], check=True)
                flash("Infrastructure created successfully!", "success")

            elif action == "destroy":
                subprocess.run([
                    "terraform", "destroy", "-auto-approve",
                    "-var", f'region={region}'
                ], check=True)
                flash("Infrastructure destroyed successfully!", "warning")

        except subprocess.CalledProcessError as e:
            flash(f"Error during Terraform execution: {e}", "danger")
        finally:
            os.chdir("..")
            # Remove AWS creds from env
            os.environ.pop("AWS_ACCESS_KEY_ID", None)
            os.environ.pop("AWS_SECRET_ACCESS_KEY", None)

        return redirect("/")

    return render_template("index.html")

if __name__ == "__main__":
    app.run(debug=True)
