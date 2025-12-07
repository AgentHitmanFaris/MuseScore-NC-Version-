# Developer Daily Checklist

This checklist is designed to help you maintain a productive and stable workflow when developing **Musescore NC Version** in the **Antigravity** IDE.

## 🌅 Start of Day

1.  **Sync Codebase**:
    *   Pull the latest changes from the remote repository. Prefer rebasing to keep a clean history.
    *   `git pull --rebase origin master` (or your working branch)

2.  **Verify Environment**:
    *   Ensure the Gemini CLI is connected and active.
    *   `gemini --version`
    *   *(Optional)* Ensure git hooks are installed (run once per machine): `hooks/install.sh`
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

2.  **Coding & Testing**:
    *   Write code and tests iteratively.
    *   **Run Tests**: Verify your changes with the test suite.
        *   **Windows**: `dev.bat test`
        *   **Linux**: `./dev.sh test`
    *   **Run App**: Launch the application to test visually.
        *   `dev.bat run`

3.  **Documentation**:
    *   If you change logic, update the relevant comments or ask Gemini to generate updated docstrings.
    *   `gemini code "Add docstrings to this function..."`

## 🌙 End of Day / Pre-Commit

1.  **Code Review & Cleanup**:
    *   Check what files you have modified.
    *   `git status`
    *   `git diff`
    *   Ensure no temporary debugging code (print statements, hardcoded paths) remains.

2.  **Pre-commit Checks**:
    *   The project uses pre-commit hooks to ensure code quality.
    *   Run the formatter manually if needed: `tools/codestyle/tidy_file.sh <file>`
    *   Run the full test suite one last time: `dev.bat test`

3.  **Commit & Push**:
    *   Commit your work with a descriptive message.
    *   `git commit -m "feat: description of work done"`
    *   **Prepare for PR**: If working on a shared branch, ensure your history is clean.
    *   `git push`

## 🚑 Troubleshooting

*   **Build Failures**: Try cleaning the build directory.
    *   `dev.bat clean`
*   **Gemini Help**: Use Gemini to diagnose errors.
    *   `gemini debug`
