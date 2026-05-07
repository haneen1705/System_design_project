How to run the project:

1. Open this folder.
2. Double click run.bat.
3. Keep the black IIS Express window open.
4. Open: http://localhost:8080/index.html

Session booking update:
- Schedule Session now saves the request through Api/Session.ashx.
- The request is stored in App_Data/sessions.jsonl.
- After scheduling, the user is redirected to session-confirmation.html instead of a browser alert.
