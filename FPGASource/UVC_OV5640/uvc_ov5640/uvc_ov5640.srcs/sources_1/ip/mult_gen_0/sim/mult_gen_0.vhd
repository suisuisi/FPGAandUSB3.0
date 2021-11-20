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

-- IP VLNV: xilinx.com:ip:mult_gen:12.0
-- IP Revision: 14

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY mult_gen_v12_0_14;
USE mult_gen_v12_0_14.mult_gen_v12_0_14;

ENTITY mult_gen_0 IS
  PORT (
    CLK : IN STD_LOGIC;
    A : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    P : OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
  );
END mult_gen_0;

ARCHITECTURE mult_gen_0_arch OF mult_gen_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF mult_gen_0_arch: ARCHITECTURE IS "yes";
  COMPONENT mult_gen_v12_0_14 IS
    GENERIC (
      C_VERBOSITY : INTEGER;
      C_MODEL_TYPE : INTEGER;
      C_OPTIMIZE_GOAL : INTEGER;
      C_XDEVICEFAMILY : STRING;
      C_HAS_CE : INTEGER;
      C_HAS_SCLR : INTEGER;
      C_LATENCY : INTEGER;
      C_A_WIDTH : INTEGER;
      C_A_TYPE : INTEGER;
      C_B_WIDTH : INTEGER;
      C_B_TYPE : INTEGER;
      C_OUT_HIGH : INTEGER;
      C_OUT_LOW : INTEGER;
      C_MULT_TYPE : INTEGER;
      C_CE_OVERRIDES_SCLR : INTEGER;
      C_CCM_IMP : INTEGER;
      C_B_VALUE : STRING;
      C_HAS_ZERO_DETECT : INTEGER;
      C_ROUND_OUTPUT : INTEGER;
      C_ROUND_PT : INTEGER
    );
    PORT (
      CLK : IN STD_LOGIC;
      A : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
      B : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      CE : IN STD_LOGIC;
      SCLR : IN STD_LOGIC;
      P : OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
    );
  END COMPONENT mult_gen_v12_0_14;
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER OF P: SIGNAL IS "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef";
  ATTRIBUTE X_INTERFACE_INFO OF P: SIGNAL IS "xilinx.com:signal:data:1.0 p_intf DATA";
  ATTRIBUTE X_INTERFACE_PARAMETER OF B: SIGNAL IS "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef";
  ATTRIBUTE X_INTERFACE_INFO OF B: SIGNAL IS "xilinx.com:signal:data:1.0 b_intf DATA";
  ATTRIBUTE X_INTERFACE_PARAMETER OF A: SIGNAL IS "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef";
  ATTRIBUTE X_INTERFACE_INFO OF A: SIGNAL IS "xilinx.com:signal:data:1.0 a_intf DATA";
  ATTRIBUTE X_INTERFACE_PARAMETER OF CLK: SIGNAL IS "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:b_intf:a_intf, ASSOCIATED_RESET sclr, ASSOCIATED_CLKEN ce, FREQ_HZ 10000000, PHASE 0.000, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF CLK: SIGNAL IS "xilinx.com:signal:clock:1.0 clk_intf CLK";
BEGIN
  U0 : mult_gen_v12_0_14
    GENERIC MAP (
      C_VERBOSITY => 0,
      C_MODEL_TYPE => 0,
      C_OPTIMIZE_GOAL => 1,
      C_XDEVICEFAMILY => "kintex7",
      C_HAS_CE => 0,
      C_HAS_SCLR => 0,
      C_LATENCY => 3,
      C_A_WIDTH => 10,
      C_A_TYPE => 1,
      C_B_WIDTH => 8,
      C_B_TYPE => 1,
      C_OUT_HIGH => 17,
      C_OUT_LOW => 0,
      C_MULT_TYPE => 1,
      C_CE_OVERRIDES_SCLR => 0,
      C_CCM_IMP => 0,
      C_B_VALUE => "10000001",
      C_HAS_ZERO_DETECT => 0,
      C_ROUND_OUTPUT => 0,
      C_ROUND_PT => 0
    )
    PORT MAP (
      CLK => CLK,
      A => A,
      B => B,
      CE => '1',
      SCLR => '0',
      P => P
    );
END mult_gen_0_arch;
