# Plan Command

You are about to create a detailed, actionable plan for implementing the user's request.

The user will provide the idea you will be working with as the first message between <idea> tags.

The plan must follow these critical requirements:

## Requirements for Each Step

Every step in the plan MUST:
1. Result in a working, compilable state
2. Pass all existing tests
3. Pass `cargo clippy --tests` (for Rust projects) or equivalent linter
4. Pass `cargo fmt` (for Rust projects) or equivalent formatter
5. Be independently committable with a clear, atomic change

## Plan Structure

When the user provides a feature request or task with `/plan <description>`, you must:

1. **Analyze the Request**
   - Break down the feature into logical, incremental components
   - Identify dependencies between components
   - Determine the minimal viable implementation for each step

2. **Create a Step-by-Step Plan**
   - Each step should be a complete, working increment
   - Steps should build upon each other logically
   - Include validation checkpoints after each step

3. **Format the Plan**
   Use the TodoWrite tool to create a structured plan with these elements for each step:
   - Clear, actionable description
   - Expected outcome
   - Validation criteria (tests, linting, formatting)
   - Commit message suggestion

## Example Plan Format

For a request like "Add user authentication to the web app", create:

```
Step 1: Set up authentication dependencies
- Add required auth libraries to Cargo.toml/package.json
- Ensure project still builds
- Run tests, clippy, fmt
- Commit: "chore: add authentication dependencies"

Step 2: Create user model and database schema
- Implement User struct/model
- Add database migrations
- Write unit tests for the model
- Run all tests, clippy, fmt
- Commit: "feat: add User model and database schema"

Step 3: Implement authentication middleware
- Create auth middleware component
- Add basic token validation
- Write integration tests
- Run all tests, clippy, fmt
- Commit: "feat: implement authentication middleware"

[Continue with more steps...]
```

## Validation Process

After creating the plan, you should:
1. Review each step for completeness
2. Ensure no step breaks the build
3. Verify that each step adds value independently
4. Confirm that the full sequence achieves the goal

## Important Notes

- **Never skip validation**: Each step must pass all checks
- **Keep steps atomic**: One logical change per step
- **Maintain backward compatibility**: Don't break existing functionality
- **Document as you go**: Include necessary documentation updates in relevant steps
- **Test incrementally**: Add tests with the code they test

## Project Type Detection

Detect the project type and adjust validation commands accordingly:
- Rust: `cargo test`, `cargo clippy --tests`, `cargo fmt`
- JavaScript/TypeScript: `npm test`, `npm run lint`, `npm run format`
- Python: `pytest`, `pylint`/`ruff`, `black`
- Go: `go test`, `golint`, `gofmt`
- Other: Adapt based on project configuration

Now, analyze the user's request and create a comprehensive, actionable plan following these guidelines.

<idea>$ARGUMENTS<idea>
