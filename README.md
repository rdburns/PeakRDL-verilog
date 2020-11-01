[![Build Status](https://travis-ci.org/SystemRDL/PeakRDL-verilog.svg?branch=master)](https://travis-ci.org/SystemRDL/PeakRDL-verilog)
[![PyPI - Python Version](https://img.shields.io/pypi/pyversions/peakrdl-verilog.svg)](https://pypi.org/project/peakrdl-verilog)

# PeakRDL-verilog
Generate Verilog register model from compiled SystemRDL input

## Installing
Install from github only at the moment.

--------------------------------------------------------------------------------

## Exporter Usage
Pass the elaborated output of the [SystemRDL Compiler](http://systemrdl-compiler.readthedocs.io)
to the exporter.

```python
import sys
from systemrdl import RDLCompiler, RDLCompileError
from peakrdl.verilog import VerilogExporter

rdlc = RDLCompiler()

try:
    rdlc.compile_file("path/to/my.rdl")
    root = rdlc.elaborate()
except RDLCompileError:
    sys.exit(1)

exporter = VerilogExporter()
exporter.export(root, "test.sv")
```
--------------------------------------------------------------------------------

## Reference

### `VerilogExporter(**kwargs)`
Constructor for the Verilog Exporter class

**Optional Parameters**

* `user_template_dir`
    * Path to a directory where user-defined template overrides are stored.
* `user_template_context`
    * Additional context variables to load into the template namespace.

### `VerilogExporter.export(node, path, **kwargs)`
Perform the export!

**Parameters**

* `node`
    * Top-level node to export. Can be the top-level `RootNode` or any internal `AddrmapNode`.
* `path`
    * Output file.

**Optional Parameters**

