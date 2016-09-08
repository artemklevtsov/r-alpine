## Overview

This repository contains Dockerfiles for different Docker containers of interest to R users.

## What is R?

R is a system for statistical computation and graphics. It consists of a language plus a run-time environment with graphics, a debugger, access to certain system functions, and the ability to run programs stored in script files.

The R language is widely used among statisticians and data miners for developing statistical software and data analysis. Polls and surveys of data miners are showing R's popularity has increased substantially in recent years.

R is an implementation of the S programming language combined with lexical scoping semantics inspired by Scheme. S was created by John Chambers while at Bell Labs. R was created by Ross Ihaka and Robert Gentleman at the University of Auckland, New Zealand, and is currently developed by the R Development Core Team, of which Chambers is a member. R is named partly after the first names of the first two R authors and partly as a play on the name of S.

R is a GNU project. The source code for the R software environment is written primarily in C, Fortran, and R. R is freely available under the GNU General Public License, and pre-compiled binary versions are provided for various operating systems. R uses a command line interface; however, several graphical user interfaces are available for use with R.

## Image Variants

| Descripiton | Tag | Dockerfile | Image Size |
|:----------- |:---:|:----------:|:----------:|
| The latest release | `3.3.1`, `release`, `latest`| [Dockerfile](https://gitlab.com/artemklevtsov/r-alpine/blob/master/release/Dockerfile) | [![](https://images.microbadger.com/badges/image/artemklevtsov/r-alpine:3.3.1.svg)](http://microbadger.com/images/artemklevtsov/r-alpine:release "Get your own image badge on microbadger.com") |
| The latest patched release |  `patched` | [Dockerfile](https://gitlab.com/artemklevtsov/r-alpine/blob/master/patched/Dockerfile) | [![](https://images.microbadger.com/badges/image/artemklevtsov/r-alpine:patched.svg)](http://microbadger.com/images/artemklevtsov/r-alpine:patched "Get your own image badge on microbadger.com")
| The latest development release | `devel` | [Dockerfile](https://gitlab.com/artemklevtsov/r-alpine/blob/master/devel/Dockerfile) | [![](https://images.microbadger.com/badges/image/artemklevtsov/r-alpine:devel.svg)](http://microbadger.com/images/artemklevtsov/r-alpine:devel "Get your own image badge on microbadger.com")

## How to use this image

### Interactive R

Launch R directly for interactive work:

```bash
$ docker run -ti --rm artemklevtsov/r-alpine:latest
```

### Batch mode

```bash
$ docker run -ti --rm -v "$PWD":/tmp/rpkgs -w /tmp/rpkgs -u guest artemklevtsov/r-alpine:latest R CMD check .
```

Alternatively, just run a bash session on the container first. This allows a user to run batch commands and also edit and run scripts:

```bash
$ docker run -ti --rm artemklevtsov/r-alpine:latest /bin/ash
$ vi myscript.R
```

Write the script in the container, exit vim and run `Rscript`:

```bash
$ Rscript myscript.R
```

## Dockerfiles

Use `r-alpine` as a base for your own Dockerfiles. For instance, something along the lines of the following will compile and run your project:

```bash
FROM artemklevtsov/r-alpine:latest
COPY . /usr/local/src/myscripts
WORKDIR /usr/local/src/myscripts
CMD ["Rscript", "myscript.R"]
```

Build your image with the command:

```bash
$ docker build -t myscript /path/to/Dockerfile
```

Running this container with no command will execute the script. Alternatively, a user could run this container in interactive or batch mode as described above, instead of linking volumes.

## License

The Dockerfiles in this repository are licensed under the GPL 2 or later. View [R-project license information](https://www.r-project.org/Licenses/) for the software contained in this image.
