# Globber

![globber](https://github.com/Native-Planet/globber/assets/97745768/83e250d0-1e5f-4550-b037-a2a065f0fa71)

- Custom globber for Native Planet.
- Heavily inspired by %docket, [tlon's glob.sh](https://github.com/tloncorp/landscape/blob/master/.github/helpers/glob.sh)  and the make-glob thread.
- For standard usage, use the bash script provided.
- Want to run the hoon yourself, look at src.

#### Difference from the other glob-makers
- %docket doesn't do glob-http.
- %docket requires authentication. This doesn't.
- make-glob requires a `|commit` that doesn't take capital letters.
- tlon's glob.sh uses make-glob.

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
