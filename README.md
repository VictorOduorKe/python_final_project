📚 Study AI Buddy – Your Personalized Study Plan Generator
# installation process

```bash
git clone https://github.com/VictorOduorKe/python_final_project.git   #---clone the repo
cd backend
python3 -m venv venv  #---create virtual environment
source venv/bin/activate #---activate the enviromnent
pip install -r requirements.txt #--istall all libraries

```
# create .env file with the following
```bash
DB_HOST=databas-host eg(localhost)
DB_NAME=database_name
DB_PASSWORD=database_password
DB_PORT=3306
DB_USER=databse_username eg (admin/root)
FLASK_ENV=development

GEMINI_API_KEY=gemini_api_key
GEMINI_API_URL=https://generativelanguage.googleapis.com/v1/models/gemini-1.5-flash
SECRET_KEY=random_secret_key (generate a hash key)
```

# CREATE THE DATABASE 
```bash
CREATE DATABASE studyAiBudyDb;
```
# CREATING TABLES----
    locate MYDB.SQL in backend folder > copy the schema and run it in your workbench
# running the program
 ```bash
   cd backend
   python3 app.py #use correct python version you installed
   # sever is set to run on port 5000
   ```
  TO VIEW YOUR BACKEND STATUS PASTE THIS URL IN BROWSER 
  http://127.0.0.1:5000
       or 
  <a href="http://127.0.0.1:5000/">VIEW SERVER STATUS</a>

   # runing frontend
   ```bash
   use liveserver to run the frontend and get the port its running on
   navigate back to backend/app.py and set the origins url to match the port your frontend is running on;
   makes sure all api endpoints in frontend/js files are pointing to http://127.0.0.1:5000

   ```
   in browser navigate to how it works on the navigation bar to start using the platform after successfull installation or visit the already hosted app here <a href="https://studyaibudy.netlify.app">view the live site</a>

Welcome to Study AI Buddy, a smart platform that helps students generate tailored study plans, take quizzes, and track learning progress—all powered by AI and a secure backend. This document explains the full development process, including frontend, backend, database, and integration with AI APIs.
[Visit my pitch deck](https://www.canva.com/design/DAGxwlZ1pHg/W4Sh_-5CifIe0os3JjfEIA/edit?utm_content=DAGxwlZ1pHg&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton "pitch dck")

Study AI Buddy allows users to:

Add subjects and track educational levels.

Generate a personalized 7-week study plan using AI.

Take quizzes automatically generated for each study plan.

Save and view quiz results, with progress bars showing performance.

Manage subjects: add, edit, or delete them.

Secure login/logout with session management.

Technologies used:

Frontend: HTML, CSS, JavaScript (Vanilla + ES6 modules)

Backend: Python Flask

Database: MySQL (with connection pooling)

AI Integration: Gemini API for generating study plans and quizzes

Session Management: Flask sessions + secure cookies

🛠️ Backend Development

The backend is built in Flask and handles:

Database connection pooling for efficiency.

User authentication with session checks.

Subject management (CRUD).

AI-driven study plan generation via Gemini API.

Quiz submission and result tracking.

📊 System Flow Diagram
1️⃣ Overall Architecture
flowchart LR
    A[Frontend (Browser)] -->|Fetch/Add Subjects| B[Flask Backend]
    B -->|Query/Update| C[MySQL Database]
    B -->|Generate Plan| D[Gemini AI API]
    D -->|JSON Response| B
    B -->|JSON Response| A


Explanation:

User interacts with the frontend.

Requests go to the Flask backend.

Backend queries MySQL database or sends prompts to Gemini API.

AI-generated study plans and quizzes are stored in the database.

Backend responds with JSON; frontend updates dynamically.

2️⃣ Study Plan Generation Flow
flowchart TD
    User[User submits subject & level] --> Backend[Flask /api/generate_plan]
    Backend --> DB_Check{Check if plan exists in DB?}
    DB_Check -->|Yes| Return_Existing[Return existing plan JSON]
    DB_Check -->|No| AI_Request[Send prompt to Gemini API]
    AI_Request --> AI_Response[Receive JSON: summary, roadmap, quiz_questions]
    AI_Response --> DB_Save[Save plan to MySQL]
    DB_Save --> Frontend[Return JSON to user]


Steps:

Backend checks if a study plan already exists for the selected subject.

If not, it sends a prompt to Gemini AI.

The AI responds with a JSON object containing the plan and quiz questions.

Backend saves the response in the database.

JSON is returned to the frontend for display.

3️⃣ Quiz Submission Flow
flowchart TD
    User[User submits quiz answers] --> Backend[POST /api/quiz/submit]
    Backend --> DB_Check{Already attempted?}
    DB_Check -->|Yes| Error_Response[Return 409 Conflict]
    DB_Check -->|No| DB_Save[Save answers, score, total to DB]
    DB_Save --> Frontend[Return success JSON]


Steps:

Backend verifies the user has not already attempted the quiz.

If yes, returns a duplicate submission error.

If no, quiz results are stored in the database.

Frontend shows the score and updates progress.

💻 Frontend Development

Uses Vanilla JS modules with async/await for API requests.

Authenticated requests include credentials: "include".

Dynamic subject list updates after add/edit/delete actions.

Auto-hide messages for user feedback.

Responsive sidebar for mobile-friendly navigation.

4️⃣ Frontend Flow for Subject Management
flowchart TD
    User[User enters new subject] --> JS[submit event handler]
    JS --> Backend[POST /api/subjects]
    Backend --> DB[Insert subject into MySQL]
    DB --> Backend[Return success JSON]
    Backend --> JS[Update UI dynamically]

🔗 How to Use / Visit

You can try the project live:

Visit Study AI Buddy:
[https://studyaibudy.netlify.app/](https://studyaibudy.netlify.app/)

Log in / register.

Add subjects and select educational levels.

After subject is added visit side bar and click Generate plan

Generate AI-driven study plans.

Take quizzes and track your progress.

⚡ Development Notes & Best Practices

Session Security: Always validate user_id in session.

Connection Pooling: Efficient DB handling for multiple users.

Error Handling: User-friendly messages on frontend; detailed logs on backend.

AI Response Handling: Always sanitize and validate AI JSON before saving.

Frontend/Backend Sync: Ensure keys (plan_id, answers, score, total) match JSON payloads.

UX Enhancements: Auto-hiding messages and dynamic DOM updates improve usability.

🎯 Conclusion

Study AI Buddy is a full-stack, AI-powered learning platform:

Python + Flask backend with MySQL database

Vanilla JS frontend with dynamic content updates

Gemini API for AI-generated study plans and quizzes

Full subject and quiz management

Scalable, secure, and user-friendly

The visual flow diagrams make it easier to understand how each component interacts.

