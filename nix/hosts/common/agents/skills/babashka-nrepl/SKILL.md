---
name: babashka-nrepl
description: Write Clojure (Babashka) scripts using REPL-driven development. Start an nREPL server and send code to it for evaluation as you develop.
---

# Preparation

To proceed with REPL-driven development, you first need to start an nREPL server.

## Optional: Create bb.edn

If additional libraries are needed, create `bb.edn` in the working directory before starting the nREPL server.

```clojure
{:deps
 { ;; Declare required dependencies here
 }}
```

If you add libraries, you need to restart the nREPL server each time.

## Start nREPL Server

The nREPL server can be started with the following command:

    bb nrepl-server ${port}

The port is arbitrary, but `1667` is used by default.
Since you will send code from another process using an nREPL client, it's recommended to start this process asynchronously.
Terminate the entire process when you're done.

# Usage

## nREPL Client

You can send Clojure (Babashka) code to the nREPL server with the following command:

    bb nrepl-eval ${port} '${code}'

However, this command requires a pre-defined `bb.edn`, so execute it in the directory where this skill exists.

## REPL-driven development

As you write functions, send them to the REPL one by one to verify their behavior.
It's recommended to verify behavior in the smallest possible units.
