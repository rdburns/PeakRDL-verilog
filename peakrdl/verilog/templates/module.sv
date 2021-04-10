{%- import 'addressable.sv' as addressable with context -%}

// This file was autogenerated by PeakRDL-verilog
module {{get_inst_name(top_node)}}_rf #(
    parameter                                ADDR_OFFSET = {{top_node.absolute_address}},  //! Module's offset in the main address map
    parameter                                ADDR_WIDTH  = 32,   //! Width of SW address bus
    parameter                                DATA_WIDTH  = 32    //! Width of SW data bus
)(
    // Clocks and resets
    input logic                              clk,     //! Default clock
    input logic                              resetn,  //! Default reset

{%- for node in top_node.descendants() -%}
 {%- if isinstance(node, RegNode) %}

    // Register {{get_inst_name(node).upper()}}
  {%- if node.has_intr %}
    output logic {{node.full_array_ranges}}        {{signal(node, '', 'intr')}}, //! Combined interrupt line for {{get_inst_name(node).upper()}}
  {%- endif -%}

 {%- elif isinstance(node, FieldNode) -%}
  {%- if node.get_property('swmod') %}
    output logic {{node.parent.full_array_ranges}}        {{signal(node, '', 'swmod')}},          //! Indicates SW has modified this field
  {%- endif %}

  {%- if node.get_property('swacc') %}
    output logic {{node.parent.full_array_ranges}}        {{signal(node, '', 'swacc')}},          //! Indicates SW has accessed this field
  {%- endif %}

  {%- if node.get_property('swwe') == True %}
    input  logic {{node.parent.full_array_ranges}}        {{signal(node, '', 'swwe')}},           //! Control SW write (active high)
  {%- elif node.get_property('swwel') == True %}
    input  logic {{node.parent.full_array_ranges}}        {{signal(node, '', 'swwel')}},          //! Control SW write (active low)
  {%- endif %}

  {%- if node.get_property('intr') %}
    // expand interrupt per field, leave open if not wanted
    output logic {{node.parent.full_array_ranges}}[{{node.bit_range_zero}}] {{signal(node, '', 'intr')}}, //! Individual interrupt line for {{get_inst_name(node).upper()}}
  {%- endif -%}

  {%- if node.get_property('hwset') == True %}
    input  logic {{node.parent.full_array_ranges}}        {{signal(node, '', 'hwset')}},          //! Set all bits high
  {%- endif %}

  {%- if node.get_property('hwclr') == True %}
    input  logic {{node.parent.full_array_ranges}}        {{signal(node, '', 'hwclr')}},          //! Set all bits low
  {%- endif %}

  {%- if node.get_property('wel') == True %}
    input  logic  {{node.parent.full_array_ranges}}       {{signal(node, '', 'wel')}},            //! Control HW write (active low)
  {%- elif node.has_we %}
    input  logic  {{node.parent.full_array_ranges}}       {{signal(node, '', 'we')}},             //! Control HW write (active high)
  {%- endif %}

  {%- if node.is_hw_writable %}
    input  logic {{node.parent.full_array_ranges}}[{{node.bit_range_zero}}] {{signal(node, '', 'wdata')}},          //! HW write data
  {%- endif -%}

  {%- if node.is_hw_readable %}
    output logic {{node.parent.full_array_ranges}}[{{node.bit_range_zero}}] {{signal(node, '', 'q')}},              //! Current field value
  {%- endif -%}

  {%- if node.get_property('anded') %}
    output logic {{node.parent.full_array_ranges}}        {{signal(node, '', 'anded')}},          //! Current field value (AND reduced)
  {%- endif -%}
  {%- if node.get_property('ored') %}
    output logic {{node.parent.full_array_ranges}}        {{signal(node, '', 'ored')}},           //! Current field value (OR reduced)
  {%- endif -%}
  {%- if node.get_property('xored') %}
    output logic {{node.parent.full_array_ranges}}        {{signal(node, '', 'xored')}},          //! Current field value (XOR reduced)
  {%- endif -%}

  {%- if node.is_up_counter %}
   {%- if not node.get_property('incr') %}
    input  logic {{node.parent.full_array_ranges}}        {{signal(node, '', 'incr')}},           //! Increment the counter
   {%- endif -%}
   {%- if node.get_property('incrwidth') %}
    input  logic {{node.parent.full_array_ranges}}[{{node.get_property('incrwidth')}}-1:0] {{signal(node, '', 'incrvalue')}},      //! Incremenet amount
   {%- endif -%}
   {%- if node.get_property('overflow') %}
    output logic {{node.parent.full_array_ranges}}        {{signal(node, '', 'overflow')}},       //! Indicates the counter has overflowed
   {%- endif -%}
   {%- if node.get_property('incrthreshold') %}
    output logic {{node.parent.full_array_ranges}}        {{signal(node, '', 'incrthreshold')}},  //! Indicates the counter has reached the upper threshold
   {%- endif -%}
   {%- if node.get_property('incrsaturate') %}
    output logic {{node.parent.full_array_ranges}}        {{signal(node, '', 'incrsaturate')}},   //! Indicates the counter has saturated at upper limit
   {%- endif -%}
  {%- endif -%}

  {%- if node.is_down_counter %}
   {%- if not node.get_property('decr') %}
    input  logic {{node.parent.full_array_ranges}}        {{signal(node, '', 'decr')}}, //! Decrement the counter
   {%- endif -%}
   {%- if node.get_property('decrwidth') %}
    input  logic {{node.parent.full_array_ranges}}[{{node.get_property('decrwidth')}}-1:0] {{signal(node, '', 'decrvalue')}}, //! Decremenet amount
   {%- endif -%}
   {%- if node.get_property('underflow') %}
    output logic {{node.parent.full_array_ranges}}        {{signal(node, '', 'underflow')}}, //! Indicates the counter has underflowed
   {%- endif -%}
   {%- if node.get_property('decrthreshold') %}
    output logic {{node.parent.full_array_ranges}}        {{signal(node, '', 'decrthreshold')}}, //! Indicates the counter has reached the lower threshold
   {%- endif -%}
   {%- if node.get_property('decrsaturate') %}
    output logic {{node.parent.full_array_ranges}}        {{signal(node, '', 'decrsaturate')}}, //! Indicates the counter has saturated at lower limit
   {%- endif -%}
  {%- endif -%}

 {%- endif -%}
{%- endfor %}

    // Register Bus
    input  logic                             valid,    //! Active high valid
    input  logic                             read,     //! Indicates request is a read
    input  logic            [ADDR_WIDTH-1:0] addr,     //! Address (byte aligned, absolute address)
    /* verilator lint_off UNUSED */
    input  logic            [DATA_WIDTH-1:0] wdata,    //! Write data
    input  logic          [DATA_WIDTH/8-1:0] wmask,    //! Write mask
    /* verilator lint_on UNUSED */
    output logic            [DATA_WIDTH-1:0] rdata     //! Read data
);

/* verilator lint_off UNUSED */
    // local output signals for fields (unless block outputs)
    // these can be used as references in other fields
{%- for node in top_node.descendants() -%}
 {%- if isinstance(node, FieldNode) -%}

  {%- if not node.is_hw_readable %}
    logic       {{node.parent.full_array_ranges}}[{{node.bit_range_zero}}] {{signal(node, '', 'q')}};
  {%- endif -%}

  {%- if not node.get_property('anded') %}
    logic {{node.parent.full_array_ranges}}        {{signal(node, '', 'anded')}};
  {%- endif -%}
  {%- if not node.get_property('ored') %}
    logic {{node.parent.full_array_ranges}}        {{signal(node, '', 'ored')}};
  {%- endif -%}
  {%- if not node.get_property('xored') %}
    logic {{node.parent.full_array_ranges}}        {{signal(node, '', 'xored')}};
  {%- endif -%}

  {%- if node.is_up_counter %}
   {%- if not node.get_property('overflow') %}
    logic {{node.parent.full_array_ranges}}        {{signal(node, '', 'overflow')}};
   {%- endif -%}
   {%- if not node.get_property('incrthreshold') %}
    logic {{node.parent.full_array_ranges}}        {{signal(node, '', 'incrthreshold')}};
   {%- endif -%}
   {%- if not node.get_property('incrsaturate') %}
    logic {{node.parent.full_array_ranges}}        {{signal(node, '', 'incrsaturate')}};
   {%- endif -%}
  {%- endif -%}

  {%- if node.is_down_counter %}
   {%- if not node.get_property('underflow') %}
    logic {{node.parent.full_array_ranges}}        {{signal(node, '', 'underflow')}};
   {%- endif -%}
   {%- if not node.get_property('decrthreshold') %}
    logic {{node.parent.full_array_ranges}}        {{signal(node, '', 'decrthreshold')}};
   {%- endif -%}
   {%- if not node.get_property('decrsaturate') %}
    logic {{node.parent.full_array_ranges}}        {{signal(node, '', 'decrsaturate')}};
   {%- endif -%}
  {%- endif -%}

 {%- endif -%}
{%- endfor %}
/* verilator lint_on UNUSED */

    // ============================================================
    // SW Access logic
    // ============================================================

/* verilator lint_off UNUSED */
    logic [DATA_WIDTH-1:0] mask;
    logic [DATA_WIDTH-1:0] masked_data;
/* verilator lint_on UNUSED */

    always_comb begin
        int byte_idx;
        for (byte_idx = 0; byte_idx < DATA_WIDTH/8; byte_idx+=1)
          mask[8*(byte_idx+1)-1 -: 8] = {8{wmask[byte_idx]}};
    end

    assign masked_data = wdata & mask;

{%- for node in top_node.descendants() -%}
{%- if isinstance(node, RegNode) %}
    logic {{node.full_array_ranges}}[DATA_WIDTH-1:0] {{signal(node, '', 'rdata')}};
{%- endif -%}
{%- endfor %}

    assign rdata = // or of each register return (masked)
{%- for node in top_node.descendants() if isinstance(node, RegNode) %}
    {%- set outer_loop = loop %}
    {%- for idx in node.full_array_indexes %}
                   {{signal(node, '', 'rdata')}}{{idx}}{{ " | " if not (outer_loop.last and loop.last)else ";" }}
    {%- endfor %}
{%- endfor %}

    {{ addressable.body(top_node)|indent}}

endmodule: {{get_inst_name(top_node)}}_rf

