-- (c) Copyright 1995-2021 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: xilinx.com:ip:v_demosaic:1.0
-- IP Revision: 4

-- The following code must appear in the VHDL architecture header.

------------- Begin Cut here for COMPONENT Declaration ------ COMP_TAG
COMPONENT v_demosaic_0
  PORT (
    s_axi_CTRL_AWADDR : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    s_axi_CTRL_AWVALID : IN STD_LOGIC;
    s_axi_CTRL_AWREADY : OUT STD_LOGIC;
    s_axi_CTRL_WDATA : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_CTRL_WSTRB : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    s_axi_CTRL_WVALID : IN STD_LOGIC;
    s_axi_CTRL_WREADY : OUT STD_LOGIC;
    s_axi_CTRL_BRESP : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_CTRL_BVALID : OUT STD_LOGIC;
    s_axi_CTRL_BREADY : IN STD_LOGIC;
    s_axi_CTRL_ARADDR : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    s_axi_CTRL_ARVALID : IN STD_LOGIC;
    s_axi_CTRL_ARREADY : OUT STD_LOGIC;
    s_axi_CTRL_RDATA : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_CTRL_RRESP : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_CTRL_RVALID : OUT STD_LOGIC;
    s_axi_CTRL_RREADY : IN STD_LOGIC;
    ap_clk : IN STD_LOGIC;
    ap_rst_n : IN STD_LOGIC;
    interrupt : OUT STD_LOGIC;
    s_axis_video_TVALID : IN STD_LOGIC;
    s_axis_video_TREADY : OUT STD_LOGIC;
    s_axis_video_TDATA : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    s_axis_video_TKEEP : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    s_axis_video_TSTRB : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    s_axis_video_TUSER : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    s_axis_video_TLAST : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    s_axis_video_TID : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    s_axis_video_TDEST : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    m_axis_video_TVALID : OUT STD_LOGIC;
    m_axis_video_TREADY : IN STD_LOGIC;
    m_axis_video_TDATA : OUT STD_LOGIC_VECTOR(23 DOWNTO 0);
    m_axis_video_TKEEP : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    m_axis_video_TSTRB : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    m_axis_video_TUSER : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    m_axis_video_TLAST : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    m_axis_video_TID : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    m_axis_video_TDEST : OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
  );
END COMPONENT;
-- COMP_TAG_END ------ End COMPONENT Declaration ------------

-- The following code must appear in the VHDL architecture
-- body. Substitute your own instance name and net names.

------------- Begin Cut here for INSTANTIATION Template ----- INST_TAG
your_instance_name : v_demosaic_0
  PORT MAP (
    s_axi_CTRL_AWADDR => s_axi_CTRL_AWADDR,
    s_axi_CTRL_AWVALID => s_axi_CTRL_AWVALID,
    s_axi_CTRL_AWREADY => s_axi_CTRL_AWREADY,
    s_axi_CTRL_WDATA => s_axi_CTRL_WDATA,
    s_axi_CTRL_WSTRB => s_axi_CTRL_WSTRB,
    s_axi_CTRL_WVALID => s_axi_CTRL_WVALID,
    s_axi_CTRL_WREADY => s_axi_CTRL_WREADY,
    s_axi_CTRL_BRESP => s_axi_CTRL_BRESP,
    s_axi_CTRL_BVALID => s_axi_CTRL_BVALID,
    s_axi_CTRL_BREADY => s_axi_CTRL_BREADY,
    s_axi_CTRL_ARADDR => s_axi_CTRL_ARADDR,
    s_axi_CTRL_ARVALID => s_axi_CTRL_ARVALID,
    s_axi_CTRL_ARREADY => s_axi_CTRL_ARREADY,
    s_axi_CTRL_RDATA => s_axi_CTRL_RDATA,
    s_axi_CTRL_RRESP => s_axi_CTRL_RRESP,
    s_axi_CTRL_RVALID => s_axi_CTRL_RVALID,
    s_axi_CTRL_RREADY => s_axi_CTRL_RREADY,
    ap_clk => ap_clk,
    ap_rst_n => ap_rst_n,
    interrupt => interrupt,
    s_axis_video_TVALID => s_axis_video_TVALID,
    s_axis_video_TREADY => s_axis_video_TREADY,
    s_axis_video_TDATA => s_axis_video_TDATA,
    s_axis_video_TKEEP => s_axis_video_TKEEP,
    s_axis_video_TSTRB => s_axis_video_TSTRB,
    s_axis_video_TUSER => s_axis_video_TUSER,
    s_axis_video_TLAST => s_axis_video_TLAST,
    s_axis_video_TID => s_axis_video_TID,
    s_axis_video_TDEST => s_axis_video_TDEST,
    m_axis_video_TVALID => m_axis_video_TVALID,
    m_axis_video_TREADY => m_axis_video_TREADY,
    m_axis_video_TDATA => m_axis_video_TDATA,
    m_axis_video_TKEEP => m_axis_video_TKEEP,
    m_axis_video_TSTRB => m_axis_video_TSTRB,
    m_axis_video_TUSER => m_axis_video_TUSER,
    m_axis_video_TLAST => m_axis_video_TLAST,
    m_axis_video_TID => m_axis_video_TID,
    m_axis_video_TDEST => m_axis_video_TDEST
  );
-- INST_TAG_END ------ End INSTANTIATION Template ---------

-- You must compile the wrapper file v_demosaic_0.vhd when simulating
-- the core, v_demosaic_0. When compiling the wrapper file, be sure to
-- reference the VHDL simulation library.

