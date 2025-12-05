# Developer Daily Checklist

This checklist is designed to help you maintain a productive and stable workflow when developing **Musescore NC Version** in the **Antigravity** IDE.

## 🌅 Start of Day

1.  **Sync Codebase**:
    *   Pull the latest changes from the remote repository to minimize merge conflicts.
    *   `git pull origin main` (or your current working branch)

2.  **Verify Environment**:
    *   Ensure the Gemini CLI is connected and active.
    *   Run: `gemini --version`

3.  **Health Check Build**:
    *   Run a quick build to ensure the current state of the codebase works on your machine.
    *   **Windows**: `dev.bat build`
    *   **Linux**: `./dev.sh build`

## 👨‍💻 Active Development

1.  **Context Gathering**:
    *   Before modifying a file, use Gemini to understand its purpose.
    *   `gemini explain <file_path>`

2.  **Coding**:
    *   Use the helper scripts to build and run frequently.
    *   `dev.bat run` to launch the application and test your changes visually.

3.  **Documentation**:
    *   If you change logic, update the relevant comments or ask Gemini to generate updated docstrings.

## 🌙 End of Day

1.  **Review Changes**:
    *   Check what files you have modified.
    *   `git status`
    *   `git diff`

2.  **Clean Code**:
    *   Ensure no temporary debugging code (print statements, hardcoded paths) remains.

3.  **Commit & Push**:
    *   Commit your work with a descriptive message.
    *   `git commit -m "feat: description of work done today"`
    *   `git push`
