# Module 5 - Activity 5 - HAUDEX app (Flutter capstone)

[![Made with Claude](https://img.shields.io/badge/Made_with-Claude-D97757?logo=anthropic&logoColor=white)](https://tjakoen.github.io/notes/ten-times-zero)
![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white)

The finale. Put the whole course together into one small, complete app: a HAUDEX you can browse, add to, and battle in.

## What to do

### 1. Fill in your details

Open `student.json` and fill in every field (use the **class code** your
instructor gave you):

```json
{
  "classCode": "1234",
  "fullName": "Juan Dela Cruz",
  "studentNumber": "2026-12345",
  "studentEmail": "juan.delacruz@hau.edu.ph",
  "personalEmail": "juan@example.com",
  "githubAccount": "juandelacruz"
}
```

> **Keep `student.json` identical across all your activities.** The autograder
> cross-checks these fields between your repos, and a mismatch (e.g. a different
> `classCode` in one activity) is flagged. The `classCode` must also match the
> one in your repo name.

### 2. Build this

Your work goes in **`lib/dex_app.dart`**.

Starting from `lib/dex_app.dart` (and splitting into more files as you go), build an app that:

- starts by showing the seed monsters (`lib/seed.dart`) in a scrollable list,
- has a **FloatingActionButton** that opens a form (dialog or screen) with a `TextField` to **add** a monster - adding it grows the list,
- lets you **tap** a monster to open a **detail** screen (`Navigator.push`) that shows the type keyed `Key('detailType')`, the current HP keyed `Key('hp')`, and an **Attack** button that lowers that monster's HP with `setState` (never below 0).

Then make it feel real: consistent styling, a smooth add flow, a detail screen with battle feedback. Split it into small, well-named widgets and files.

**How it is graded:** 100 points = 40 automated (the interactions above) + 60 design/UX (from a phone-framed screenshot and your code). See `RUBRIC.md`.

## Set up your repo

Before you write any code, create **your own copy** of this activity from the
template. Do not work in the template itself.

1. **Create from the template.** Open the template repo and click
   **Use this template -> Create a new repository**.
2. **Set the owner to the course org.** Under *Owner*, choose the **`HAU-6ADET`
   course org**, **not** your personal account.
3. **Name it by the convention** `m<module>a<activity>-<classcode>-<yourname>`.
   For this activity that's **`m5a5-<classcode>-yourname`** (e.g.
   `m5a5-1234-juandelacruz`). The `<classcode>` must match the one in
   `student.json`.
4. **Make it Private** so classmates can't see your work.

Then clone **your** new repo and work there:

```bash
git clone https://github.com/HAU-6ADET/m5a5-<classcode>-yourname.git
cd m5a5-<classcode>-yourname
```

## Run and check

```bash
flutter pub get              # fetch packages
flutter run -d chrome        # on your own laptop: launches Chrome
flutter test                 # run the checks
```

> **In a Codespace, run with `-d web-server` instead.** A Codespace has no phone
> emulator and no browser inside it, so `-d chrome` cannot work there. Use:
>
> ```bash
> flutter run -d web-server --web-port=8080 --web-hostname=0.0.0.0
> ```
>
> Codespaces forwards port 8080 for you. Click **Open in Browser** on the pop-up,
> or open the **Ports** tab and click the globe next to 8080. device_preview still
> wraps your app in a phone frame so it looks like a phone. Press `R` in the
> terminal to restart after a change (on recent Flutter `r` hot-reloads too), or
> `q` to stop it.

You do not need to touch `lib/main.dart` - it just launches your screen inside a
mobile preview so you can see it as a phone. Your instructor's grader also takes
a **screenshot** of your screen inside a phone frame, so make it something you
would be happy to show.

What the tests check:

- ✅ `student.json` is filled in
- ✅ lists the seed monsters
- ✅ has a FloatingActionButton to add a monster
- ✅ the add button opens a form with a TextField
- ✅ tapping a monster opens its detail screen
- ✅ the detail's Attack lowers HP and never goes negative

Each part is graded independently, so you earn partial credit.

## Confirm your submission

Your repo **is** your submission, so there is nothing to upload. When the tests
pass, **commit and push** so your work is recorded:

```bash
git add -A
git commit -m "Activity complete"
git push
```

Pushing triggers the **Autograde** workflow, which shows a pass/fail summary.

## Codespaces

Click **Code -> Codespaces -> Create codespace**. The Flutter SDK is already set
up; run the commands above in the terminal.

### ⏱️ Make your free hours last (please read)
Your GitHub Education account includes a generous but limited monthly Codespaces
allowance. Three habits keep you from wasting it:

1. **Set your idle timeout to 10 minutes.** Go to
   **github.com/settings/codespaces -> Default idle timeout -> 10 minutes -> Save.**
2. **Stop it when you finish - don't just close the tab.** Stop it at
   **github.com/codespaces -> ••• -> Stop codespace**, or run
   *Codespaces: Stop Current Codespace* from the Command Palette.
3. **Delete the Codespace once you've submitted this activity.** After your
   final push: **github.com/codespaces -> ••• -> Delete.** You can recreate it
   later from the green **Code** button.

---
📚 **These materials were authored by [tjakoen](https://github.com/tjakoen), built with Claude.** I use AI in the open, and I expect you to use it to learn the material, not to skip the learning. [How I actually work with AI ->](https://tjakoen.github.io/notes/ten-times-zero)
