# MentorHub Backend

A lightweight ASP.NET backend for the MentorHub platform using `.ashx` Web Handlers and JSONL-based storage.

## Overview

MentorHub uses a simple backend architecture built with ASP.NET Web Handlers (`.ashx`) to handle:

- User Registration
- User Login
- Contact Messages
- Session Booking
- Health Check APIs

Instead of using SQL databases, the current version stores data locally using JSONL files inside `App_Data`.

---

# Backend Architecture

## Frontend
HTML pages and JavaScript collect user input from forms such as:

- Register
- Login
- Contact
- Session Booking

The frontend sends requests to backend APIs.

---

## Backend

The backend consists of `.ashx` API handlers located inside:

```bash
/Api
````

Each handler is responsible for a single operation.

---

## Storage

Data is stored as JSON Lines (`.jsonl`) files inside:

```bash
/App_Data
```

Each request creates a new JSON object appended as a new line.

---

# Project Structure

```bash
System_design_project_WITH_CONFIRMATION/
├── run.bat
└── project_systemDesign/
    ├── index.html
    ├── register.html
    ├── login.html
    ├── contact.html
    ├── connect-with-mentor.html
    ├── session-confirmation.html
    ├── Api/
    │   ├── Register.ashx
    │   ├── Login.ashx
    │   ├── Contact.ashx
    │   ├── Session.ashx
    │   └── Health.ashx
    ├── App_Data/
    └── Web.config
```

---

# API Endpoints

## Register API

### Endpoint

```bash
/Api/Register.ashx
```

### Purpose

Registers a new user and stores the data in:

```bash
App_Data/users.jsonl
```

### Input

| Field | Type   |
| ----- | ------ |
| name  | string |
| email | string |
| role  | string |

### Response

```json
{
  "success": true,
  "user": {}
}
```

---

## Login API

### Endpoint

```bash
/Api/Login.ashx
```

### Purpose

Stores login attempts in:

```bash
App_Data/logins.jsonl
```

### Input

| Field | Type   |
| ----- | ------ |
| email | string |

### Notes

* Current version does NOT validate passwords
* This is a demo authentication flow

### Response

```json
{
  "success": true,
  "user": {}
}
```

---

## Contact API

### Endpoint

```bash
/Api/Contact.ashx
```

### Purpose

Stores contact messages in:

```bash
App_Data/messages.jsonl
```

### Input

| Field   | Type   |
| ------- | ------ |
| name    | string |
| email   | string |
| phone   | string |
| role    | string |
| message | string |

### Response

```json
{
  "success": true
}
```

---

## Session Booking API

### Endpoint

```bash
/Api/Session.ashx
```

### Purpose

Stores booked sessions in:

```bash
App_Data/sessions.jsonl
```

### Input

| Field        | Type   |
| ------------ | ------ |
| fullName     | string |
| email        | string |
| promoCode    | string |
| sessionDate  | string |
| sessionMonth | string |
| sessionTime  | string |

### Response

```json
{
  "success": true,
  "session": {}
}
```

---

## Health Check API

### Endpoint

```bash
/Api/Health.ashx
```

### Purpose

Checks whether the backend is running properly.

### Example Response

```json
{
  "ok": true,
  "app": "MentorHub"
}
```

---

# Request Flow

## Register Flow

```text
register.html
    ↓
Api/Register.ashx
    ↓
App_Data/users.jsonl
    ↓
JSON Response
```

---

## Contact Flow

```text
contact.html
    ↓
Api/Contact.ashx
    ↓
App_Data/messages.jsonl
    ↓
success/error response
```

---

## Booking Flow

```text
connect-with-mentor.html
    ↓
Api/Session.ashx
    ↓
App_Data/sessions.jsonl
    ↓
confirmation page
```

---

# JSONL Storage

## What is JSONL?

JSONL stands for:

```text
JSON Lines
```

Each line inside the file is a separate JSON object.

Example:

```json
{"type":"register","name":"Yousef","email":"yousef@gmail.com"}
{"type":"login","email":"yousef@gmail.com"}
```

---

# Why JSONL Instead of SQL?

This version uses JSONL because:

* Lightweight
* Fast local setup
* No SQL Server installation required
* Easy demo deployment
* Simple append operations using:

```csharp
File.AppendAllText()
```

The project can later be upgraded to:

* SQL Server
* Entity Framework
* ADO.NET

---

# Web.config

`Web.config` handles:

* ASP.NET settings
* IIS Express configuration
* Error handling
* Framework versions

### Important Settings

```xml
<customErrors mode="Off" />
<compilation debug="true" targetFramework="4.7.2" />
<httpErrors errorMode="Detailed" />
```

---

# Running the Project

## Requirements

* IIS Express
* .NET Framework 4.7.2

---

## Start the Server

Run:

```bash
run.bat
```

The script:

* Detects IIS Express
* Starts the server on port `8080`
* Opens the browser automatically

---

## Open the Project

```bash
http://localhost:8080/index.html
```

---

## Test Backend Health

```bash
http://localhost:8080/Api/Health.ashx
```

---

# Key Backend Concepts

## ASP.NET Web Handlers

Each `.ashx` file acts as an independent API endpoint.

Example:

```csharp
public class RegisterHandler : IHttpHandler
```

---

## Request Processing

Each API:

1. Receives HTTP Request
2. Reads form data
3. Creates a record object
4. Saves JSON to App_Data
5. Returns JSON response

---

# Security Notes

Current demo version:

* Does not validate passwords
* Does not prevent duplicate emails
* Does not implement real authentication

Future improvements may include:

* Password hashing
* JWT Authentication
* SQL Database integration
* Email validation
* Duplicate checking

---

# Discussion Notes

## Where is the backend located?

```bash
project_systemDesign/Api
```

---

## Where is data stored?

```bash
App_Data/*.jsonl
```

---

## Does the project use SQL?

No.

Current APIs use JSONL file-based storage.

---

## What is the purpose of `run.bat`?

It starts IIS Express and launches the project locally.

---

## What is the purpose of `Web.config`?

It manages ASP.NET runtime configuration and debugging settings.

---

# Tech Stack

* ASP.NET Web Handlers (.ashx)
* C#
* IIS Express
* JSONL Storage
* HTML/CSS/JavaScript

---

# Future Improvements

* SQL Server integration
* Real authentication system
* Password hashing
* Admin dashboard
* API validation
* Session management
* Deployment support

---

# Summary

MentorHub backend is a lightweight ASP.NET API system that:

* Receives requests from frontend pages
* Processes user data
* Stores records in JSONL files
* Returns JSON responses

----------------------------------------
