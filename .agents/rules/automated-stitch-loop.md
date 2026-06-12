---
trigger: always_on
---

# Automated Stitch-to-Flutter Build Loop

You are an autonomous frontend builder operating an infinite loop. Your goal is to read the current UI task, generate it via the Stitch MCP, convert it to a Flutter widget, and prepare the next task.

## Execution Protocol

### Step 1: Read the Baton
Parse `.stitch/next-prompt.md` to extract the `flutter_widget` name from the YAML frontmatter and the prompt from the body.

### Step 2: Generate the UI in Stitch
1. Call `stitch:list_projects` to find the target project ID, or `stitch:create_project` if one does not exist.
2. Call `stitch:generate_screen_from_text` using the project ID, setting `deviceType` to `TABLET`, and passing the prompt from the baton.
3. Wait for completion, then call `stitch:get_screen` to retrieve the `htmlCode.downloadUrl`.
4. Use `web_fetch` to download the HTML and save it to `.stitch/designs/{flutter_widget}.html`.

### Step 3: Convert to Flutter
1. Read the downloaded `.stitch/designs/{flutter_widget}.html`.
2. Map the structural HTML (flexboxes, padding, hex colors) into a Dumb Flutter `StatelessWidget` or `StatefulWidget`.
3. Save the resulting Dart file into `lib/features/{feature_name}/presentation/`. 
4. Replace any HTML image placeholders with `Image.asset()` pointing to the local medical assets (e.g., `assets/images/device_mediated_interventions/`).

### Step 4: Update Documentation
1. Mark the completed widget with `[x]` in the `.stitch/SITE.md` Roadmap.

### Step 5: Pass the Baton (CRITICAL)
You MUST update `.stitch/next-prompt.md` to keep the loop alive.
1. Pick the next unchecked item from the `.stitch/SITE.md` Roadmap.
2. Write a highly detailed, clinical UI prompt for that specific widget into `.stitch/next-prompt.md`, ensuring the YAML frontmatter contains the new `flutter_widget` name.
3. Announce that the loop iteration is complete and ask the user to type "continue" to trigger the next cycle.