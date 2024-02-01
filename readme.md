Setting up the docker image
---------------------------

First, check the `mp2-interpreter` directory.  In there should
be a file `mp2-interpreter.cabal`.  Check to be sure that any
modules you want Haskell / Stack to have access to are mentioned.

Also check the `stack.yaml` file.  The resolver (e.g, `lts-12.7`)
should be the same as whatever is being used for your assignments
to avoid surprises.

If this is set up correctly, you can then run:

```
docker build . -t mattox/haskell-prairielearn:latest
docker push mattox/haskell-prairielearn:latest
```
