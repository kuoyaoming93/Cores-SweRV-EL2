#  NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE
#  This is an automatically generated file by kuo on vie 09 jun 2023 00:36:35 CEST
# 
#  cmd:    swerv -target=default -set build_axi4 
# 
# To use this in a perf script, use 'require $RV_ROOT/configs/config.pl'
# Reference the hash via $config{name}..


%config = (
            'protection' => {
                              'data_access_addr6' => '0x00000000',
                              'data_access_enable7' => '0x0',
                              'data_access_enable6' => '0x0',
                              'inst_access_addr2' => '0x00000000',
                              'inst_access_addr0' => '0x00000000',
                              'inst_access_addr1' => '0x00000000',
                              'data_access_addr4' => '0x00000000',
                              'data_access_enable3' => '0x0',
                              'data_access_addr1' => '0x00000000',
                              'data_access_addr0' => '0x00000000',
                              'data_access_addr2' => '0x00000000',
                              'inst_access_addr6' => '0x00000000',
                              'inst_access_enable7' => '0x0',
                              'inst_access_enable6' => '0x0',
                              'inst_access_enable3' => '0x0',
                              'inst_access_addr4' => '0x00000000',
                              'inst_access_mask0' => '0xffffffff',
                              'inst_access_mask1' => '0xffffffff',
                              'inst_access_mask2' => '0xffffffff',
                              'data_access_enable5' => '0x0',
                              'data_access_mask6' => '0xffffffff',
                              'data_access_enable2' => '0x0',
                              'data_access_mask4' => '0xffffffff',
                              'inst_access_enable5' => '0x0',
                              'inst_access_mask6' => '0xffffffff',
                              'data_access_mask2' => '0xffffffff',
                              'data_access_mask0' => '0xffffffff',
                              'data_access_mask1' => '0xffffffff',
                              'inst_access_mask4' => '0xffffffff',
                              'inst_access_enable2' => '0x0',
                              'data_access_addr3' => '0x00000000',
                              'data_access_mask7' => '0xffffffff',
                              'data_access_enable1' => '0x0',
                              'inst_access_addr5' => '0x00000000',
                              'inst_access_enable0' => '0x0',
                              'data_access_enable4' => '0x0',
                              'inst_access_mask7' => '0xffffffff',
                              'inst_access_addr3' => '0x00000000',
                              'inst_access_enable4' => '0x0',
                              'data_access_addr5' => '0x00000000',
                              'data_access_enable0' => '0x0',
                              'inst_access_enable1' => '0x0',
                              'data_access_addr7' => '0x00000000',
                              'data_access_mask3' => '0xffffffff',
                              'inst_access_mask5' => '0xffffffff',
                              'inst_access_mask3' => '0xffffffff',
                              'inst_access_addr7' => '0x00000000',
                              'data_access_mask5' => '0xffffffff'
                            },
            'btb' => {
                       'btb_index1_lo' => '2',
                       'btb_array_depth' => 256,
                       'btb_index3_lo' => 18,
                       'btb_btag_size' => 5,
                       'btb_index2_hi' => 17,
                       'btb_toffset_size' => '12',
                       'btb_addr_hi' => 9,
                       'btb_addr_lo' => '2',
                       'btb_index1_hi' => 9,
                       'btb_index2_lo' => 10,
                       'btb_size' => 512,
                       'btb_index3_hi' => 25,
                       'btb_enable' => '1',
                       'btb_fold2_index_hash' => 0,
                       'btb_btag_fold' => 0
                     },
            'testbench' => {
                             'lderr_rollback' => '1',
                             'build_axi_native' => 1,
                             'RV_TOP' => '`TOP.rvtop',
                             'sterr_rollback' => '0',
                             'CPU_TOP' => '`RV_TOP.swerv',
                             'assert_on' => '',
                             'TOP' => 'tb_top',
                             'build_axi4' => 1,
                             'ext_addrwidth' => '32',
                             'ext_datawidth' => '64',
                             'SDVT_AHB' => '0',
                             'clock_period' => '100'
                           },
            'triggers' => [
                            {
                              'reset' => [
                                           '0x23e00000',
                                           '0x00000000',
                                           '0x00000000'
                                         ],
                              'mask' => [
                                          '0x081818c7',
                                          '0xffffffff',
                                          '0x00000000'
                                        ],
                              'poke_mask' => [
                                               '0x081818c7',
                                               '0xffffffff',
                                               '0x00000000'
                                             ]
                            },
                            {
                              'poke_mask' => [
                                               '0x081810c7',
                                               '0xffffffff',
                                               '0x00000000'
                                             ],
                              'mask' => [
                                          '0x081810c7',
                                          '0xffffffff',
                                          '0x00000000'
                                        ],
                              'reset' => [
                                           '0x23e00000',
                                           '0x00000000',
                                           '0x00000000'
                                         ]
                            },
                            {
                              'reset' => [
                                           '0x23e00000',
                                           '0x00000000',
                                           '0x00000000'
                                         ],
                              'poke_mask' => [
                                               '0x081818c7',
                                               '0xffffffff',
                                               '0x00000000'
                                             ],
                              'mask' => [
                                          '0x081818c7',
                                          '0xffffffff',
                                          '0x00000000'
                                        ]
                            },
                            {
                              'poke_mask' => [
                                               '0x081810c7',
                                               '0xffffffff',
                                               '0x00000000'
                                             ],
                              'mask' => [
                                          '0x081810c7',
                                          '0xffffffff',
                                          '0x00000000'
                                        ],
                              'reset' => [
                                           '0x23e00000',
                                           '0x00000000',
                                           '0x00000000'
                                         ]
                            }
                          ],
            'bht' => {
                       'bht_ghr_range' => '7:0',
                       'bht_size' => 512,
                       'bht_ghr_size' => 8,
                       'bht_addr_lo' => '2',
                       'bht_ghr_hash_1' => '',
                       'bht_hash_string' => '{hashin[8+1:2]^ghr[8-1:0]}// cf2',
                       'bht_array_depth' => 256,
                       'bht_addr_hi' => 9
                     },
            'dccm' => {
                        'dccm_rows' => '4096',
                        'dccm_data_width' => 32,
                        'dccm_sadr' => '0xf0040000',
                        'dccm_enable' => '1',
                        'dccm_offset' => '0x40000',
                        'dccm_num_banks' => '4',
                        'dccm_num_banks_4' => '',
                        'dccm_bits' => 16,
                        'dccm_eadr' => '0xf004ffff',
                        'dccm_data_cell' => 'ram_4096x39',
                        'dccm_width_bits' => 2,
                        'dccm_reserved' => '0x1400',
                        'dccm_size' => 64,
                        'dccm_fdata_width' => 39,
                        'dccm_size_64' => '',
                        'dccm_ecc_width' => 7,
                        'dccm_region' => '0xf',
                        'lsu_sb_bits' => 16,
                        'dccm_index_bits' => 12,
                        'dccm_byte_width' => '4',
                        'dccm_bank_bits' => 2
                      },
            'retstack' => {
                            'ret_stack_size' => '8'
                          },
            'bus' => {
                       'lsu_bus_tag' => 3,
                       'bus_prty_default' => '3',
                       'dma_bus_prty' => '2',
                       'ifu_bus_prty' => '2',
                       'sb_bus_id' => '1',
                       'lsu_bus_id' => '1',
                       'ifu_bus_tag' => '3',
                       'dma_bus_id' => '1',
                       'dma_bus_tag' => '1',
                       'sb_bus_prty' => '2',
                       'lsu_bus_prty' => '2',
                       'sb_bus_tag' => '1',
                       'ifu_bus_id' => '1'
                     },
            'xlen' => 32,
            'tec_rv_icg' => 'clockhdr',
            'pic' => {
                       'pic_meipt_offset' => '0x3004',
                       'pic_meie_offset' => '0x2000',
                       'pic_meipl_mask' => '0xf',
                       'pic_meipl_count' => 31,
                       'pic_meigwctrl_offset' => '0x4000',
                       'pic_meigwctrl_mask' => '0x3',
                       'pic_meipl_offset' => '0x0000',
                       'pic_mpiccfg_offset' => '0x3000',
                       'pic_meipt_mask' => '0x0',
                       'pic_meie_mask' => '0x1',
                       'pic_meigwctrl_count' => 31,
                       'pic_base_addr' => '0xf00c0000',
                       'pic_region' => '0xf',
                       'pic_meipt_count' => 31,
                       'pic_total_int_plus1' => 32,
                       'pic_size' => 32,
                       'pic_meip_count' => 1,
                       'pic_offset' => '0xc0000',
                       'pic_meigwclr_count' => 31,
                       'pic_meigwclr_mask' => '0x0',
                       'pic_total_int' => 31,
                       'pic_mpiccfg_mask' => '0x1',
                       'pic_bits' => 15,
                       'pic_meip_offset' => '0x1000',
                       'pic_meigwclr_offset' => '0x5000',
                       'pic_meie_count' => 31,
                       'pic_mpiccfg_count' => 1,
                       'pic_meip_mask' => '0x0',
                       'pic_int_words' => 1
                     },
            'reset_vec' => '0x80000000',
            'nmi_vec' => '0x11110000',
            'harts' => 1,
            'even_odd_trigger_chains' => 'true',
            'memmap' => {
                          'unused_region1' => '0x70000000',
                          'unused_region0' => '0x90000000',
                          'debug_sb_mem' => '0xa0580000',
                          'unused_region3' => '0x50000000',
                          'unused_region2' => '0x60000000',
                          'unused_region7' => '0x10000000',
                          'unused_region8' => '0x00000000',
                          'consoleio' => '0xd0580000',
                          'unused_region5' => '0x30000000',
                          'serialio' => '0xd0580000',
                          'external_data' => '0xc0580000',
                          'unused_region4' => '0x40000000',
                          'unused_region6' => '0x20000000',
                          'external_data_1' => '0xb0000000'
                        },
            'regwidth' => '32',
            'perf_events' => [
                               1,
                               2,
                               3,
                               4,
                               5,
                               6,
                               7,
                               8,
                               9,
                               10,
                               11,
                               12,
                               13,
                               14,
                               15,
                               16,
                               17,
                               18,
                               19,
                               20,
                               21,
                               22,
                               23,
                               24,
                               25,
                               26,
                               27,
                               28,
                               30,
                               31,
                               32,
                               34,
                               35,
                               36,
                               37,
                               38,
                               39,
                               40,
                               41,
                               42,
                               43,
                               44,
                               45,
                               46,
                               47,
                               48,
                               49,
                               50,
                               54,
                               55,
                               56,
                               512,
                               513,
                               514,
                               515,
                               516
                             ],
            'numiregs' => '32',
            'config_key' => '32\'hdeadbeef',
            'core' => {
                        'dma_buf_depth' => '5',
                        'bitmanip_zbb' => 1,
                        'lsu_num_nbload_width' => '2',
                        'iccm_icache' => 1,
                        'bitmanip_zbc' => 1,
                        'div_bit' => '4',
                        'lsu2dma' => 0,
                        'iccm_only' => 'derived',
                        'bitmanip_zbe' => 0,
                        'div_new' => 1,
                        'timer_legal_en' => '1',
                        'icache_only' => 'derived',
                        'fast_interrupt_redirect' => '1',
                        'bitmanip_zbs' => 1,
                        'fpga_optimize' => 1,
                        'bitmanip_zbf' => 0,
                        'bitmanip_zbr' => 0,
                        'lsu_num_nbload' => '4',
                        'lsu_stbuf_depth' => '4',
                        'no_iccm_no_icache' => 'derived',
                        'bitmanip_zba' => 1,
                        'bitmanip_zbp' => 0
                      },
            'target' => 'default',
            'physical' => '1',
            'icache' => {
                          'icache_data_width' => 64,
                          'icache_tag_lo' => 13,
                          'icache_tag_index_lo' => '6',
                          'icache_bank_bits' => 1,
                          'icache_num_bypass_width' => 2,
                          'icache_tag_cell' => 'ram_128x25',
                          'icache_size' => 16,
                          'icache_tag_num_bypass' => '2',
                          'icache_tag_depth' => 128,
                          'icache_index_hi' => 12,
                          'icache_num_ways' => 2,
                          'icache_beat_addr_hi' => 5,
                          'icache_banks_way' => 2,
                          'icache_bypass_enable' => '1',
                          'icache_bank_width' => 8,
                          'icache_num_beats' => 8,
                          'icache_data_cell' => 'ram_512x71',
                          'icache_waypack' => '1',
                          'icache_num_lines_way' => '128',
                          'icache_data_depth' => '512',
                          'icache_status_bits' => 1,
                          'icache_num_bypass' => '2',
                          'icache_bank_lo' => 3,
                          'icache_scnd_last' => 6,
                          'icache_tag_bypass_enable' => '1',
                          'icache_ecc' => '1',
                          'icache_beat_bits' => 3,
                          'icache_data_index_lo' => 4,
                          'icache_ln_sz' => 64,
                          'icache_enable' => 1,
                          'icache_bank_hi' => 3,
                          'icache_fdata_width' => 71,
                          'icache_num_lines' => 256,
                          'icache_num_lines_bank' => '64',
                          'icache_tag_num_bypass_width' => 2,
                          'icache_2banks' => '1'
                        },
            'iccm' => {
                        'iccm_size' => 64,
                        'iccm_reserved' => '0x1000',
                        'iccm_eadr' => '0xee00ffff',
                        'iccm_data_cell' => 'ram_4096x39',
                        'iccm_index_bits' => 12,
                        'iccm_bank_bits' => 2,
                        'iccm_size_64' => '',
                        'iccm_region' => '0xe',
                        'iccm_bank_index_lo' => 4,
                        'iccm_enable' => 1,
                        'iccm_offset' => '0xe000000',
                        'iccm_rows' => '4096',
                        'iccm_sadr' => '0xee000000',
                        'iccm_num_banks' => '4',
                        'iccm_num_banks_4' => '',
                        'iccm_bits' => 16,
                        'iccm_bank_hi' => 3
                      },
            'csr' => {
                       'pmpcfg2' => {
                                      'exists' => 'false'
                                    },
                       'mcounteren' => {
                                         'exists' => 'false'
                                       },
                       'mitctl1' => {
                                      'exists' => 'true',
                                      'reset' => '0x1',
                                      'mask' => '0x0000000f',
                                      'number' => '0x7d7'
                                    },
                       'pmpcfg1' => {
                                      'exists' => 'false'
                                    },
                       'mhpmcounter4' => {
                                           'exists' => 'true',
                                           'reset' => '0x0',
                                           'mask' => '0xffffffff'
                                         },
                       'pmpaddr12' => {
                                        'exists' => 'false'
                                      },
                       'mscause' => {
                                      'reset' => '0x0',
                                      'exists' => 'true',
                                      'number' => '0x7ff',
                                      'mask' => '0x0000000f'
                                    },
                       'mdccmect' => {
                                       'number' => '0x7f2',
                                       'mask' => '0xffffffff',
                                       'exists' => 'true',
                                       'reset' => '0x0'
                                     },
                       'miccmect' => {
                                       'exists' => 'true',
                                       'reset' => '0x0',
                                       'mask' => '0xffffffff',
                                       'number' => '0x7f1'
                                     },
                       'pmpaddr14' => {
                                        'exists' => 'false'
                                      },
                       'tselect' => {
                                      'reset' => '0x0',
                                      'exists' => 'true',
                                      'mask' => '0x3'
                                    },
                       'mcgc' => {
                                   'exists' => 'true',
                                   'reset' => '0x200',
                                   'number' => '0x7f8',
                                   'poke_mask' => '0x000003ff',
                                   'mask' => '0x000003ff'
                                 },
                       'mhpmcounter4h' => {
                                            'reset' => '0x0',
                                            'exists' => 'true',
                                            'mask' => '0xffffffff'
                                          },
                       'mfdc' => {
                                   'number' => '0x7f9',
                                   'mask' => '0x00071fff',
                                   'exists' => 'true',
                                   'reset' => '0x00070040'
                                 },
                       'mitcnt1' => {
                                      'exists' => 'true',
                                      'reset' => '0x0',
                                      'mask' => '0xffffffff',
                                      'number' => '0x7d5'
                                    },
                       'pmpaddr15' => {
                                        'exists' => 'false'
                                      },
                       'pmpaddr3' => {
                                       'exists' => 'false'
                                     },
                       'mhpmcounter3h' => {
                                            'reset' => '0x0',
                                            'exists' => 'true',
                                            'mask' => '0xffffffff'
                                          },
                       'marchid' => {
                                      'mask' => '0x0',
                                      'reset' => '0x00000010',
                                      'exists' => 'true'
                                    },
                       'pmpaddr11' => {
                                        'exists' => 'false'
                                      },
                       'instret' => {
                                      'exists' => 'false'
                                    },
                       'pmpaddr5' => {
                                       'exists' => 'false'
                                     },
                       'meicidpl' => {
                                       'exists' => 'true',
                                       'reset' => '0x0',
                                       'number' => '0xbcb',
                                       'mask' => '0xf',
                                       'comment' => 'External interrupt claim id priority level.'
                                     },
                       'mitbnd0' => {
                                      'reset' => '0xffffffff',
                                      'exists' => 'true',
                                      'number' => '0x7d3',
                                      'mask' => '0xffffffff'
                                    },
                       'dicawics' => {
                                       'reset' => '0x0',
                                       'exists' => 'true',
                                       'number' => '0x7c8',
                                       'mask' => '0x0130fffc',
                                       'comment' => 'Cache diagnostics.',
                                       'debug' => 'true'
                                     },
                       'micect' => {
                                     'number' => '0x7f0',
                                     'mask' => '0xffffffff',
                                     'reset' => '0x0',
                                     'exists' => 'true'
                                   },
                       'mimpid' => {
                                     'mask' => '0x0',
                                     'exists' => 'true',
                                     'reset' => '0x4'
                                   },
                       'dicago' => {
                                     'comment' => 'Cache diagnostics.',
                                     'debug' => 'true',
                                     'reset' => '0x0',
                                     'exists' => 'true',
                                     'mask' => '0x0',
                                     'number' => '0x7cb'
                                   },
                       'pmpaddr0' => {
                                       'exists' => 'false'
                                     },
                       'mhpmevent6' => {
                                         'mask' => '0xffffffff',
                                         'exists' => 'true',
                                         'reset' => '0x0'
                                       },
                       'pmpaddr8' => {
                                       'exists' => 'false'
                                     },
                       'time' => {
                                   'exists' => 'false'
                                 },
                       'dmst' => {
                                   'number' => '0x7c4',
                                   'mask' => '0x0',
                                   'reset' => '0x0',
                                   'exists' => 'true',
                                   'debug' => 'true',
                                   'comment' => 'Memory synch trigger: Flush caches in debug mode.'
                                 },
                       'mip' => {
                                  'reset' => '0x0',
                                  'exists' => 'true',
                                  'mask' => '0x0',
                                  'poke_mask' => '0x70000888'
                                },
                       'pmpaddr13' => {
                                        'exists' => 'false'
                                      },
                       'mhpmcounter3' => {
                                           'exists' => 'true',
                                           'reset' => '0x0',
                                           'mask' => '0xffffffff'
                                         },
                       'mhpmcounter6' => {
                                           'exists' => 'true',
                                           'reset' => '0x0',
                                           'mask' => '0xffffffff'
                                         },
                       'mhartid' => {
                                      'reset' => '0x0',
                                      'exists' => 'true',
                                      'mask' => '0x0',
                                      'poke_mask' => '0xfffffff0'
                                    },
                       'pmpcfg3' => {
                                      'exists' => 'false'
                                    },
                       'dicad0' => {
                                     'number' => '0x7c9',
                                     'mask' => '0xffffffff',
                                     'exists' => 'true',
                                     'reset' => '0x0',
                                     'comment' => 'Cache diagnostics.',
                                     'debug' => 'true'
                                   },
                       'mfdhs' => {
                                    'comment' => 'Force Debug Halt Status',
                                    'number' => '0x7cf',
                                    'mask' => '0x00000003',
                                    'exists' => 'true',
                                    'reset' => '0x0'
                                  },
                       'mrac' => {
                                   'comment' => 'Memory region io and cache control.',
                                   'mask' => '0xffffffff',
                                   'number' => '0x7c0',
                                   'shared' => 'true',
                                   'exists' => 'true',
                                   'reset' => '0x0'
                                 },
                       'pmpaddr4' => {
                                       'exists' => 'false'
                                     },
                       'cycle' => {
                                    'exists' => 'false'
                                  },
                       'pmpaddr7' => {
                                       'exists' => 'false'
                                     },
                       'mfdht' => {
                                    'mask' => '0x0000003f',
                                    'number' => '0x7ce',
                                    'shared' => 'true',
                                    'reset' => '0x0',
                                    'exists' => 'true',
                                    'comment' => 'Force Debug Halt Threshold'
                                  },
                       'meipt' => {
                                    'reset' => '0x0',
                                    'exists' => 'true',
                                    'number' => '0xbc9',
                                    'mask' => '0xf',
                                    'comment' => 'External interrupt priority threshold.'
                                  },
                       'pmpaddr1' => {
                                       'exists' => 'false'
                                     },
                       'mhpmcounter6h' => {
                                            'reset' => '0x0',
                                            'exists' => 'true',
                                            'mask' => '0xffffffff'
                                          },
                       'mitctl0' => {
                                      'reset' => '0x1',
                                      'exists' => 'true',
                                      'number' => '0x7d4',
                                      'mask' => '0x00000007'
                                    },
                       'pmpcfg0' => {
                                      'exists' => 'false'
                                    },
                       'meicurpl' => {
                                       'mask' => '0xf',
                                       'number' => '0xbcc',
                                       'exists' => 'true',
                                       'reset' => '0x0',
                                       'comment' => 'External interrupt current priority level.'
                                     },
                       'mhpmevent3' => {
                                         'mask' => '0xffffffff',
                                         'reset' => '0x0',
                                         'exists' => 'true'
                                       },
                       'mcountinhibit' => {
                                            'exists' => 'true',
                                            'reset' => '0x0',
                                            'mask' => '0x7d',
                                            'poke_mask' => '0x7d',
                                            'commnet' => 'Performance counter inhibit. One bit per counter.'
                                          },
                       'mvendorid' => {
                                        'mask' => '0x0',
                                        'exists' => 'true',
                                        'reset' => '0x45'
                                      },
                       'mhpmcounter5' => {
                                           'exists' => 'true',
                                           'reset' => '0x0',
                                           'mask' => '0xffffffff'
                                         },
                       'pmpaddr9' => {
                                       'exists' => 'false'
                                     },
                       'mitbnd1' => {
                                      'reset' => '0xffffffff',
                                      'exists' => 'true',
                                      'mask' => '0xffffffff',
                                      'number' => '0x7d6'
                                    },
                       'pmpaddr10' => {
                                        'exists' => 'false'
                                      },
                       'mie' => {
                                  'mask' => '0x70000888',
                                  'reset' => '0x0',
                                  'exists' => 'true'
                                },
                       'dicad1' => {
                                     'mask' => '0x3',
                                     'number' => '0x7ca',
                                     'reset' => '0x0',
                                     'exists' => 'true',
                                     'comment' => 'Cache diagnostics.',
                                     'debug' => 'true'
                                   },
                       'pmpaddr6' => {
                                       'exists' => 'false'
                                     },
                       'pmpaddr2' => {
                                       'exists' => 'false'
                                     },
                       'mitcnt0' => {
                                      'number' => '0x7d2',
                                      'mask' => '0xffffffff',
                                      'exists' => 'true',
                                      'reset' => '0x0'
                                    },
                       'mcpc' => {
                                   'exists' => 'true',
                                   'reset' => '0x0',
                                   'number' => '0x7c2',
                                   'mask' => '0x0',
                                   'comment' => 'Core pause'
                                 },
                       'mstatus' => {
                                      'mask' => '0x88',
                                      'reset' => '0x1800',
                                      'exists' => 'true'
                                    },
                       'mhpmevent4' => {
                                         'mask' => '0xffffffff',
                                         'exists' => 'true',
                                         'reset' => '0x0'
                                       },
                       'mhpmcounter5h' => {
                                            'mask' => '0xffffffff',
                                            'exists' => 'true',
                                            'reset' => '0x0'
                                          },
                       'mpmc' => {
                                   'reset' => '0x2',
                                   'exists' => 'true',
                                   'number' => '0x7c6',
                                   'mask' => '0x2'
                                 },
                       'misa' => {
                                   'mask' => '0x0',
                                   'reset' => '0x40001104',
                                   'exists' => 'true'
                                 },
                       'dcsr' => {
                                   'debug' => 'true',
                                   'poke_mask' => '0x00008dcc',
                                   'mask' => '0x00008c04',
                                   'reset' => '0x40000003',
                                   'exists' => 'true'
                                 },
                       'mhpmevent5' => {
                                         'mask' => '0xffffffff',
                                         'reset' => '0x0',
                                         'exists' => 'true'
                                       }
                     },
            'num_mmode_perf_regs' => '4',
            'max_mmode_perf_event' => '516'
          );
1;
