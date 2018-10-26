# STOTP
STOTP is an implementation of the time based one time pad (TOTP) written in SPARK.
It currently only supports SHA-1 but since it is based on the [libsparkcrypto](https://github.com/Componolit/libsparkcrypto/) further algorithms can be added.

The library includes a toolset to generate tokens for twe factor authentication from provided base32 keys:

 - [Base32 encoder/decoder](https://github.com/jklmnn/STOTP/blob/master/src/base32.ads) (without padding support)
 - [HOTP implementation](https://github.com/jklmnn/STOTP/blob/master/src/otp-h.ads) ([RFC 4226](https://tools.ietf.org/html/rfc4226))
 - [TOTP implementation](https://github.com/jklmnn/STOTP/blob/master/src/otp-t.ads) ([RFC 6238](https://tools.ietf.org/html/rfc6238))
 - [OTP Value generator for different lengths](https://github.com/jklmnn/STOTP/blob/master/src/otp.ads)

The code proves for the absence of runtime errors and the correctness of its dependencies.

## Usage

### Requirements

To build the project the [GNAT GPL toolchain](https://www.adacore.com/download/) is required.

### Build
 
 - `$ git clone https://github.com/jklmnn/STOTP.git`
 - `$ cd STOTP`
 - `$ git submodule update --init --recursive`
 - `$ gprbuild -P stotp.gpr`

### Prove

 - `$ gnatprove -P stotp.gpr`

### Example

The project file builds an example application that takes a base32 key and generates the current TOTP token:

 - `$ ./build/generate_2fa_token <base32 key>`

### Tests

The project also builds some simple tests to check the outputs of core packages.
These are executables in the `build` directory prefixed with `test_` and all of them should only output `TRUE` one or multiple times.

### Basic usage

To get a basic understanding in how to use the library take a look at the files in `examples` and `tests`.
Also all specifications in `src` are annotated. Further documentation might probably follow
