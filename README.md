# Globber
- Custom globber for Native Planet.
- Heavily inspired by %docket and the make-glob thread.
- For standard usage, use the bash script provided.
- Want to run the hoon yourself, look at src.

## Bash Script

- `./glob.sh <your/ui/directory>`

#### This command:
- Downloads Native Planet's globzod.
- Globs your directory.
- Puts the `.glob` in your current working directory.
- Deletes globzod.

## Src
- Put `src/app/globber.hoon` in `landscape/app/globber.hoon`
- Put `src/lib/globber.hoon` in `landscape/lib/globber.hoon`
- `|rein %landscape [& %globber]`
- Modify `URL` in `glob.sh`
- `./glob.sh`
