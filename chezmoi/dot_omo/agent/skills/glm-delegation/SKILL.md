---
name: glm-delegation
description: "GLM cost optimization: delegate aggressively to cheaper sub-agents for all non-trivial work. Use when working on any multi-step task."
metadata:
  short-description: GLM delegation directive
---

# GLM Delegation Directive

**DEFAULT BEHAVIOR: DELEGATE. DO NOT WORK YOURSELF.**

GLM is expensive. Delegate to cheaper sub-agents (explore, librarian, quick, etc.)
for all non-trivial work. You should only do it yourself when the task is
trivially simple (1-2 lines). Otherwise: DELEGATE. ALWAYS.

Before any implementation with 2+ steps, invoke the plan agent first.

## Task Type → Action

| Task | Action |
|---|---|
| Codebase exploration | `task(subagent_type="explore", load_skills=[], run_in_background=true)` |
| Documentation lookup | `task(subagent_type="librarian", load_skills=[], run_in_background=true)` |
| Planning | `task(subagent_type="plan", load_skills=[], run_in_background=false)` |
| Hard problem | `task(subagent_type="oracle", load_skills=[], run_in_background=false)` |
| Implementation | `task(category="quick", load_skills=[], run_in_background=true)` |

## Rules

- PARALLEL: Fire independent agent calls simultaneously.
- BACKGROUND FIRST: Use task for exploration/research agents.
- DELEGATE: Don't do everything yourself — orchestrate specialized agents.
