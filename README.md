# CP4I Architect Prep (C1000-204)

An offline-first Flutter app for preparing for **IBM Certified Cloud Pak for Integration v16.1.0
Solution Architect – Professional (C1000-204)**. It teaches with a strict five-question mastery
engine, explains every answer in depth, tracks weak concepts, and simulates the timed 64-question exam.

> **Unofficial study aid.** All 603 questions are original practice questions written against IBM's
> published C1000-204 objectives. They are not actual exam questions, and the app is not affiliated
> with or endorsed by IBM. Verify exam details (64 questions, 90 minutes, 43 to pass) on IBM's
> certification site before your exam.

## Features

| Area | What it does |
|---|---|
| **Learning journey** | 7 domains unlocked in blueprint order. Every round has **exactly 5 questions**; **only 5/5 passes**. A domain is *Mastered* only when **every question in it has been covered by a passed round**. Statuses: Not Started, In Progress, Retry Required, Mastered. Mastered domains can be revisited for revision rounds. |
| **Retry engine** | A failed round is retried with a **new** set that prioritizes the missed questions, weak concepts and unseen questions. A retry is never identical to the previous set. The final partial round is padded with previously missed revision questions so it still has 5 questions. |
| **Explanations** | For every question: your answer, the correct answer, explanation and technical background, why each option is right or wrong, an enterprise scenario with architecture implications, an exam tip and common mistakes, the IBM component, version applicability and a documentation link. |
| **Practice** | Category, random, advanced, scenario-based, troubleshooting, weak-area, bookmarked, incorrect-only and advanced revision. Unlimited rounds; unseen questions are exhausted before any repeat. |
| **Mock exam** | 64 questions weighted 11/9/14/4/11/8/7 by domain, 90-minute countdown with auto-submit, navigator grid, mark for review, answered/unanswered indicators. No feedback until you submit. Results show PASS/FAIL against 43/64, score, %, time used, domain breakdown, weakest concepts and recommended revision, plus a full answer review. |
| **Analytics** | Dashboard (progress, attempted/remaining, accuracy, study streak, mastery streak, exam attempts, last score, weakest domains), accuracy-by-domain and daily-accuracy charts (fl_chart), mock exam trend, study history, weak-area tracker (a concept counts as recovered after 3 consecutive correct answers). |
| **Offline and resume** | Everything is stored in SQLite (Drift). Close the app mid-round or mid-exam and it resumes on the same question, with the same answers, flags, option order and timer deadline. |
| **UX** | Material 3 navy and blue theme, light, dark and system modes, large touch targets, radio or checkbox answers, bottom navigation on phones and a navigation rail on tablets. Option order is shuffled per round so you cannot memorize answer letters. |

## Question bank (603 questions)

| Domain | Weight | Questions | Mock exam |
|---|---:|---:|---:|
| CP4I Overview | 17% | 102 | 11 |
| Container Platform Architecture | 14% | 84 | 9 |
| Product Capabilities & Use Cases | 22% | 132 | 14 |
| Storage Considerations | 6% | 36 | 4 |
| Scaling & Resiliency | 17% | 102 | 11 |
| Security | 13% | 78 | 8 |
| Observability | 11% | 69 | 7 |

* Difficulty: 20.4% beginner, 36.0% intermediate, 33.7% advanced, 10.0% expert.
* Style: 21.9% fundamental, 42.0% scenario/architecture, 23.5% troubleshooting, 12.6% advanced design.
  That makes 78% practical reasoning. 28 questions are multiple-select and state how many options to pick.
* Stored as compact JSON in `assets/questions/` (see `tool/validate_bank.py` for the row format), parsed
  by `QuestionBankParser`, and imported into SQLite on first launch. IDs are stable (`OVR-001`…).
  To add questions, append rows to a file (or add a file to `index.json`) and bump `bankVersion`.
  Existing progress is kept.
* Validate the bank with `python3 tool/validate_bank.py`. It checks structure, answer references,
  rationales, multi-select wording, duplicates, per-domain targets and the distributions.

Questions were written from IBM CP4I 16.1.0, API Connect 10.0.8, MQ 9.4, DataPower 10.6,
Event Automation and Red Hat OpenShift documentation. Where a feature is version-dependent (for example
ImageDigestMirrorSet versus ImageContentSourcePolicy, Native HA cross-region replication, or the
IntegrationRuntime versus IntegrationServer CR), the question says so. Review the questions against the
latest documentation before relying on any single fact.

## Architecture

Clean Architecture, feature-first, with Riverpod for DI and state and GoRouter for navigation.

```
lib/
  core/        constants (blueprint), database (Drift schema), error, router, theme, utils, widgets, providers
  features/
    questions/  domain (Question, QuestionBank) · data (parser, repository) · presentation (question/explanation widgets)
    learning/   domain (MasteryEngine, models) · data (progress & round repositories) · presentation (controller, screens)
    practice/   domain (PracticeSelector) · presentation
    mock_exam/  domain (ExamEngine) · data (ExamRepository) · presentation (controller with timer, screens)
    dashboard/  analytics/  bookmarks/  profile/ (settings)  onboarding/ (splash)
```

* **Domain engines are pure Dart** (`MasteryEngine`, `PracticeSelector`, `ExamEngine`) with injectable
  `Random` and clock, so they are fully unit-tested.
* **Database tables:** `categories`, `questions`, `user_answers`, `learning_rounds`, `category_progress`,
  `mock_exams`, `bookmarks`, `weak_concepts`, `app_meta`. Foreign keys are enforced (`PRAGMA foreign_keys`),
  with indexes on question category and concept, answer question and time, and round category and status.
  There are check constraints and unique keys, plus a versioned `MigrationStrategy`.
* Correct answers are never rendered before submission; option order is shuffled per round or exam and stored.

### Dependency notes
`flutter_riverpod`, `go_router`, `drift` + `drift_flutter`, `shared_preferences`, `fl_chart`, `path_provider`;
dev: `drift_dev`, `build_runner`. Deliberately **not** used:
* `freezed` and `json_serializable`: Drift already generates the data classes, and the domain models are small
  hand-written immutable classes, so another code generator adds no value.
* `sqlite3_flutter_libs`: it is end-of-life; `sqlite3` 3.x bundles SQLite through build hooks, used by `drift_flutter`.
* `flutter_secure_storage` and `connectivity_plus`: the app stores no secrets and has no sync feature yet.
  Add them when cloud backup or sync is implemented.

Built with Flutter 3.50 (Material via `package:material_ui`).

## Build and run

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # regenerates app_database.g.dart
flutter test
flutter run
```

### Android APK
```bash
flutter build apk --release            # build/app/outputs/flutter-apk/app-release.apk
flutter build apk --split-per-abi      # smaller per-architecture APKs
flutter build appbundle                # Play Store bundle
```
The release build is signed with the debug key by default (template setting). For distribution, create
a keystore and configure `signingConfigs` in `android/app/build.gradle.kts`.

### iOS
iOS builds require macOS with Xcode:
```bash
cd ios && pod install && cd ..
flutter build ios --release     # then archive in Xcode (Runner.xcworkspace)
```
Set your Team and bundle identifier (`com.cp4iprep.cp4iExamPrep`) in Xcode before archiving.

## Tests (41)

| # | Requirement | Test |
|---|---|---|
| 1 | Five questions load correctly | `mastery_engine_test` (1.) |
| 2, 3 | Correct and incorrect answers scored | `mastery_engine_test` (2/3.) |
| 4, 5 | 5/5 PASS, 4/5 and below FAIL | `mastery_engine_test` (4., 5.) and widget test |
| 6 | Failed rounds cannot unlock the next category | `mastery_engine_test` (6.), `persistence_test` |
| 7, 8 | Retry gives a new set and prioritizes missed questions | `mastery_engine_test` (7/8.), `persistence_test` |
| 9, 10 | All category questions covered, then completion | `mastery_engine_test` (9/10.) for every domain |
| 11, 13 | 64-question weighted exam; 43/64 passes, 42 fails | `exam_engine_test` |
| 12 | Exam timer and auto-expiry with time capped at 90 min | `exam_engine_test` (fake clock) |
| 14 | Progress survives restart | `persistence_test` (file database reopened) |
| 15 | Works offline | `persistence_test` (network calls throw) |
| 16 | Multi-select needs all correct options | `mastery_engine_test` (16.) |
| 17 | Randomization without unnecessary duplication | `mastery_engine_test` (17.) |
| 18 | Navigation preserves answers | `widget_test` (18.) |
| – | Bank validation (counts, uniqueness, distributions) | `question_bank_test` |
| – | Phone (360, 412) and tablet (1024) layouts render without overflow | `widget_test` |
