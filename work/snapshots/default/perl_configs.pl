#  NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE
#  This is an automatically generated file by kuo on mié 31 may 2023 22:32:45 CEST
# 
#  cmd:    swerv -target=default -set build_axi4 
# 
# To use this in a perf script, use 'require $RV_ROOT/configs/config.pl'
# Reference the hash via $config{name}..


%config = (
            'retstack' => {
                            'ret_stack_size' => '8'
                          },
            'config_key' => '32\'hdeadbeef',
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
            'reset_vec' => '0x80000000',
            'num_mmode_perf_regs' => '4',
            'regwidth' => '32',
            'icache' => {
                          'icache_num_bypass' => '2',
                          'icache_num_ways' => 2,
                          'icache_data_width' => 64,
                          'icache_2banks' => '1',
                          'icache_waypack' => '1',
                          'icache_data_cell' => 'ram_512x71',
                          'icache_beat_bits' => 3,
                          'icache_enable' => 1,
                          'icache_bank_lo' => 3,
                          'icache_data_index_lo' => 4,
                          'icache_num_lines' => 256,
                          'icache_fdata_width' => 71,
                          'icache_status_bits' => 1,
                          'icache_ecc' => '1',
                          'icache_data_depth' => '512',
                          'icache_bank_hi' => 3,
                          'icache_ln_sz' => 64,
                          'icache_tag_num_bypass' => '2',
                          'icache_tag_index_lo' => '6',
                          'icache_banks_way' => 2,
                          'icache_size' => 16,
                          'icache_num_lines_bank' => '64',
                          'icache_tag_num_bypass_width' => 2,
                          'icache_tag_lo' => 13,
                          'icache_tag_bypass_enable' => '1',
                          'icache_num_lines_way' => '128',
                          'icache_bypass_enable' => '1',
                          'icache_index_hi' => 12,
                          'icache_num_beats' => 8,
                          'icache_tag_cell' => 'ram_128x25',
                          'icache_scnd_last' => 6,
                          'icache_bank_bits' => 1,
                          'icache_bank_width' => 8,
                          'icache_tag_depth' => 128,
                          'icache_num_bypass_width' => 2,
                          'icache_beat_addr_hi' => 5
                        },
            'physical' => '1',
            'harts' => 1,
            'bht' => {
                       'bht_addr_lo' => '2',
                       'bht_array_depth' => 256,
                       'bht_ghr_hash_1' => '',
                       'bht_ghr_size' => 8,
                       'bht_addr_hi' => 9,
                       'bht_ghr_range' => '7:0',
                       'bht_size' => 512,
                       'bht_hash_string' => '{hashin[8+1:2]^ghr[8-1:0]}// cf2'
                     },
            'csr' => {
                       'meicidpl' => {
                                       'number' => '0xbcb',
                                       'reset' => '0x0',
                                       'mask' => '0xf',
                                       'comment' => 'External interrupt claim id priority level.',
                                       'exists' => 'true'
                                     },
                       'mitbnd1' => {
                                      'exists' => 'true',
                                      'mask' => '0xffffffff',
                                      'reset' => '0xffffffff',
                                      'number' => '0x7d6'
                                    },
                       'mitcnt1' => {
                                      'exists' => 'true',
                                      'number' => '0x7d5',
                                      'reset' => '0x0',
                                      'mask' => '0xffffffff'
                                    },
                       'mrac' => {
                                   'mask' => '0xffffffff',
                                   'reset' => '0x0',
                                   'comment' => 'Memory region io and cache control.',
                                   'number' => '0x7c0',
                                   'exists' => 'true',
                                   'shared' => 'true'
                                 },
                       'pmpaddr1' => {
                                       'exists' => 'false'
                                     },
                       'pmpaddr9' => {
                                       'exists' => 'false'
                                     },
                       'meipt' => {
                                    'number' => '0xbc9',
                                    'mask' => '0xf',
                                    'reset' => '0x0',
                                    'comment' => 'External interrupt priority threshold.',
                                    'exists' => 'true'
                                  },
                       'pmpaddr10' => {
                                        'exists' => 'false'
                                      },
                       'pmpaddr5' => {
                                       'exists' => 'false'
                                     },
                       'dicawics' => {
                                       'exists' => 'true',
                                       'debug' => 'true',
                                       'number' => '0x7c8',
                                       'mask' => '0x0130fffc',
                                       'reset' => '0x0',
                                       'comment' => 'Cache diagnostics.'
                                     },
                       'pmpaddr4' => {
                                       'exists' => 'false'
                                     },
                       'pmpaddr7' => {
                                       'exists' => 'false'
                                     },
                       'mitcnt0' => {
                                      'exists' => 'true',
                                      'reset' => '0x0',
                                      'mask' => '0xffffffff',
                                      'number' => '0x7d2'
                                    },
                       'mitbnd0' => {
                                      'exists' => 'true',
                                      'reset' => '0xffffffff',
                                      'mask' => '0xffffffff',
                                      'number' => '0x7d3'
                                    },
                       'mhpmevent4' => {
                                         'mask' => '0xffffffff',
                                         'reset' => '0x0',
                                         'exists' => 'true'
                                       },
                       'mcpc' => {
                                   'comment' => 'Core pause',
                                   'reset' => '0x0',
                                   'mask' => '0x0',
                                   'number' => '0x7c2',
                                   'exists' => 'true'
                                 },
                       'mscause' => {
                                      'exists' => 'true',
                                      'number' => '0x7ff',
                                      'mask' => '0x0000000f',
                                      'reset' => '0x0'
                                    },
                       'mie' => {
                                  'exists' => 'true',
                                  'mask' => '0x70000888',
                                  'reset' => '0x0'
                                },
                       'pmpaddr13' => {
                                        'exists' => 'false'
                                      },
                       'mhpmcounter4h' => {
                                            'reset' => '0x0',
                                            'mask' => '0xffffffff',
                                            'exists' => 'true'
                                          },
                       'mitctl1' => {
                                      'number' => '0x7d7',
                                      'reset' => '0x1',
                                      'mask' => '0x0000000f',
                                      'exists' => 'true'
                                    },
                       'mhartid' => {
                                      'mask' => '0x0',
                                      'reset' => '0x0',
                                      'poke_mask' => '0xfffffff0',
                                      'exists' => 'true'
                                    },
                       'mhpmcounter4' => {
                                           'mask' => '0xffffffff',
                                           'reset' => '0x0',
                                           'exists' => 'true'
                                         },
                       'mcounteren' => {
                                         'exists' => 'false'
                                       },
                       'meicurpl' => {
                                       'exists' => 'true',
                                       'comment' => 'External interrupt current priority level.',
                                       'mask' => '0xf',
                                       'reset' => '0x0',
                                       'number' => '0xbcc'
                                     },
                       'pmpaddr14' => {
                                        'exists' => 'false'
                                      },
                       'mitctl0' => {
                                      'number' => '0x7d4',
                                      'mask' => '0x00000007',
                                      'reset' => '0x1',
                                      'exists' => 'true'
                                    },
                       'pmpaddr11' => {
                                        'exists' => 'false'
                                      },
                       'pmpaddr6' => {
                                       'exists' => 'false'
                                     },
                       'mhpmevent3' => {
                                         'exists' => 'true',
                                         'reset' => '0x0',
                                         'mask' => '0xffffffff'
                                       },
                       'mpmc' => {
                                   'exists' => 'true',
                                   'number' => '0x7c6',
                                   'mask' => '0x2',
                                   'reset' => '0x2'
                                 },
                       'dicad1' => {
                                     'exists' => 'true',
                                     'debug' => 'true',
                                     'number' => '0x7ca',
                                     'reset' => '0x0',
                                     'mask' => '0x3',
                                     'comment' => 'Cache diagnostics.'
                                   },
                       'mdccmect' => {
                                       'number' => '0x7f2',
                                       'reset' => '0x0',
                                       'mask' => '0xffffffff',
                                       'exists' => 'true'
                                     },
                       'pmpaddr15' => {
                                        'exists' => 'false'
                                      },
                       'mimpid' => {
                                     'exists' => 'true',
                                     'reset' => '0x4',
                                     'mask' => '0x0'
                                   },
                       'pmpaddr12' => {
                                        'exists' => 'false'
                                      },
                       'mstatus' => {
                                      'mask' => '0x88',
                                      'reset' => '0x1800',
                                      'exists' => 'true'
                                    },
                       'mcgc' => {
                                   'number' => '0x7f8',
                                   'mask' => '0x000003ff',
                                   'reset' => '0x200',
                                   'poke_mask' => '0x000003ff',
                                   'exists' => 'true'
                                 },
                       'mcountinhibit' => {
                                            'exists' => 'true',
                                            'commnet' => 'Performance counter inhibit. One bit per counter.',
                                            'poke_mask' => '0x7d',
                                            'mask' => '0x7d',
                                            'reset' => '0x0'
                                          },
                       'dicad0' => {
                                     'exists' => 'true',
                                     'debug' => 'true',
                                     'number' => '0x7c9',
                                     'reset' => '0x0',
                                     'mask' => '0xffffffff',
                                     'comment' => 'Cache diagnostics.'
                                   },
                       'mhpmcounter3h' => {
                                            'reset' => '0x0',
                                            'mask' => '0xffffffff',
                                            'exists' => 'true'
                                          },
                       'mhpmcounter6' => {
                                           'reset' => '0x0',
                                           'mask' => '0xffffffff',
                                           'exists' => 'true'
                                         },
                       'dcsr' => {
                                   'reset' => '0x40000003',
                                   'mask' => '0x00008c04',
                                   'poke_mask' => '0x00008dcc',
                                   'exists' => 'true',
                                   'debug' => 'true'
                                 },
                       'pmpaddr8' => {
                                       'exists' => 'false'
                                     },
                       'mhpmcounter6h' => {
                                            'exists' => 'true',
                                            'mask' => '0xffffffff',
                                            'reset' => '0x0'
                                          },
                       'mhpmevent6' => {
                                         'mask' => '0xffffffff',
                                         'reset' => '0x0',
                                         'exists' => 'true'
                                       },
                       'mhpmcounter3' => {
                                           'mask' => '0xffffffff',
                                           'reset' => '0x0',
                                           'exists' => 'true'
                                         },
                       'pmpcfg1' => {
                                      'exists' => 'false'
                                    },
                       'mfdhs' => {
                                    'number' => '0x7cf',
                                    'reset' => '0x0',
                                    'mask' => '0x00000003',
                                    'comment' => 'Force Debug Halt Status',
                                    'exists' => 'true'
                                  },
                       'instret' => {
                                      'exists' => 'false'
                                    },
                       'dicago' => {
                                     'debug' => 'true',
                                     'exists' => 'true',
                                     'number' => '0x7cb',
                                     'comment' => 'Cache diagnostics.',
                                     'reset' => '0x0',
                                     'mask' => '0x0'
                                   },
                       'mfdc' => {
                                   'reset' => '0x00070040',
                                   'mask' => '0x00071fff',
                                   'number' => '0x7f9',
                                   'exists' => 'true'
                                 },
                       'mip' => {
                                  'poke_mask' => '0x70000888',
                                  'exists' => 'true',
                                  'mask' => '0x0',
                                  'reset' => '0x0'
                                },
                       'pmpcfg0' => {
                                      'exists' => 'false'
                                    },
                       'mvendorid' => {
                                        'reset' => '0x45',
                                        'mask' => '0x0',
                                        'exists' => 'true'
                                      },
                       'micect' => {
                                     'reset' => '0x0',
                                     'mask' => '0xffffffff',
                                     'number' => '0x7f0',
                                     'exists' => 'true'
                                   },
                       'pmpaddr3' => {
                                       'exists' => 'false'
                                     },
                       'pmpaddr0' => {
                                       'exists' => 'false'
                                     },
                       'miccmect' => {
                                       'exists' => 'true',
                                       'mask' => '0xffffffff',
                                       'reset' => '0x0',
                                       'number' => '0x7f1'
                                     },
                       'dmst' => {
                                   'number' => '0x7c4',
                                   'mask' => '0x0',
                                   'reset' => '0x0',
                                   'comment' => 'Memory synch trigger: Flush caches in debug mode.',
                                   'exists' => 'true',
                                   'debug' => 'true'
                                 },
                       'pmpcfg2' => {
                                      'exists' => 'false'
                                    },
                       'pmpcfg3' => {
                                      'exists' => 'false'
                                    },
                       'mhpmevent5' => {
                                         'exists' => 'true',
                                         'reset' => '0x0',
                                         'mask' => '0xffffffff'
                                       },
                       'tselect' => {
                                      'reset' => '0x0',
                                      'mask' => '0x3',
                                      'exists' => 'true'
                                    },
                       'pmpaddr2' => {
                                       'exists' => 'false'
                                     },
                       'mhpmcounter5h' => {
                                            'exists' => 'true',
                                            'reset' => '0x0',
                                            'mask' => '0xffffffff'
                                          },
                       'cycle' => {
                                    'exists' => 'false'
                                  },
                       'marchid' => {
                                      'mask' => '0x0',
                                      'reset' => '0x00000010',
                                      'exists' => 'true'
                                    },
                       'mhpmcounter5' => {
                                           'exists' => 'true',
                                           'mask' => '0xffffffff',
                                           'reset' => '0x0'
                                         },
                       'misa' => {
                                   'reset' => '0x40001104',
                                   'mask' => '0x0',
                                   'exists' => 'true'
                                 },
                       'mfdht' => {
                                    'mask' => '0x0000003f',
                                    'reset' => '0x0',
                                    'comment' => 'Force Debug Halt Threshold',
                                    'number' => '0x7ce',
                                    'exists' => 'true',
                                    'shared' => 'true'
                                  },
                       'time' => {
                                   'exists' => 'false'
                                 }
                     },
            'max_mmode_perf_event' => '516',
            'bus' => {
                       'lsu_bus_id' => '1',
                       'sb_bus_id' => '1',
                       'sb_bus_prty' => '2',
                       'dma_bus_id' => '1',
                       'ifu_bus_id' => '1',
                       'bus_prty_default' => '3',
                       'lsu_bus_prty' => '2',
                       'lsu_bus_tag' => 3,
                       'sb_bus_tag' => '1',
                       'dma_bus_tag' => '1',
                       'ifu_bus_prty' => '2',
                       'ifu_bus_tag' => '3',
                       'dma_bus_prty' => '2'
                     },
            'testbench' => {
                             'RV_TOP' => '`TOP.rvtop',
                             'ext_addrwidth' => '32',
                             'sterr_rollback' => '0',
                             'assert_on' => '',
                             'build_axi4' => 1,
                             'clock_period' => '100',
                             'CPU_TOP' => '`RV_TOP.swerv',
                             'lderr_rollback' => '1',
                             'SDVT_AHB' => '0',
                             'TOP' => 'tb_top',
                             'build_axi_native' => 1,
                             'ext_datawidth' => '64'
                           },
            'memmap' => {
                          'unused_region8' => '0x00000000',
                          'external_data' => '0xc0580000',
                          'unused_region6' => '0x20000000',
                          'unused_region3' => '0x50000000',
                          'consoleio' => '0xd0580000',
                          'debug_sb_mem' => '0xa0580000',
                          'unused_region2' => '0x60000000',
                          'unused_region7' => '0x10000000',
                          'external_data_1' => '0xb0000000',
                          'unused_region4' => '0x40000000',
                          'unused_region0' => '0x90000000',
                          'unused_region5' => '0x30000000',
                          'unused_region1' => '0x70000000',
                          'serialio' => '0xd0580000'
                        },
            'numiregs' => '32',
            'even_odd_trigger_chains' => 'true',
            'xlen' => 32,
            'tec_rv_icg' => 'clockhdr',
            'core' => {
                        'bitmanip_zbr' => 0,
                        'lsu_num_nbload_width' => '2',
                        'bitmanip_zbp' => 0,
                        'iccm_icache' => 1,
                        'iccm_only' => 'derived',
                        'bitmanip_zbb' => 1,
                        'lsu_num_nbload' => '4',
                        'dma_buf_depth' => '5',
                        'bitmanip_zba' => 1,
                        'lsu_stbuf_depth' => '4',
                        'no_iccm_no_icache' => 'derived',
                        'fpga_optimize' => 1,
                        'bitmanip_zbc' => 1,
                        'lsu2dma' => 0,
                        'div_bit' => '4',
                        'div_new' => 1,
                        'bitmanip_zbs' => 1,
                        'bitmanip_zbf' => 0,
                        'bitmanip_zbe' => 0,
                        'icache_only' => 'derived',
                        'timer_legal_en' => '1',
                        'fast_interrupt_redirect' => '1'
                      },
            'triggers' => [
                            {
                              'poke_mask' => [
                                               '0x081818c7',
                                               '0xffffffff',
                                               '0x00000000'
                                             ],
                              'mask' => [
                                          '0x081818c7',
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
                              'mask' => [
                                          '0x081810c7',
                                          '0xffffffff',
                                          '0x00000000'
                                        ],
                              'poke_mask' => [
                                               '0x081810c7',
                                               '0xffffffff',
                                               '0x00000000'
                                             ]
                            },
                            {
                              'poke_mask' => [
                                               '0x081818c7',
                                               '0xffffffff',
                                               '0x00000000'
                                             ],
                              'reset' => [
                                           '0x23e00000',
                                           '0x00000000',
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
            'iccm' => {
                        'iccm_reserved' => '0x1000',
                        'iccm_bank_hi' => 3,
                        'iccm_num_banks_4' => '',
                        'iccm_num_banks' => '4',
                        'iccm_index_bits' => 12,
                        'iccm_size_64' => '',
                        'iccm_offset' => '0xe000000',
                        'iccm_enable' => 1,
                        'iccm_data_cell' => 'ram_4096x39',
                        'iccm_bits' => 16,
                        'iccm_sadr' => '0xee000000',
                        'iccm_region' => '0xe',
                        'iccm_size' => 64,
                        'iccm_bank_bits' => 2,
                        'iccm_bank_index_lo' => 4,
                        'iccm_rows' => '4096',
                        'iccm_eadr' => '0xee00ffff'
                      },
            'dccm' => {
                        'dccm_rows' => '4096',
                        'dccm_eadr' => '0xf004ffff',
                        'dccm_width_bits' => 2,
                        'lsu_sb_bits' => 16,
                        'dccm_bank_bits' => 2,
                        'dccm_fdata_width' => 39,
                        'dccm_sadr' => '0xf0040000',
                        'dccm_region' => '0xf',
                        'dccm_size' => 64,
                        'dccm_enable' => '1',
                        'dccm_data_cell' => 'ram_4096x39',
                        'dccm_ecc_width' => 7,
                        'dccm_bits' => 16,
                        'dccm_byte_width' => '4',
                        'dccm_num_banks' => '4',
                        'dccm_num_banks_4' => '',
                        'dccm_index_bits' => 12,
                        'dccm_size_64' => '',
                        'dccm_offset' => '0x40000',
                        'dccm_reserved' => '0x1400',
                        'dccm_data_width' => 32
                      },
            'pic' => {
                       'pic_meipl_offset' => '0x0000',
                       'pic_meipl_count' => 31,
                       'pic_meip_offset' => '0x1000',
                       'pic_meie_offset' => '0x2000',
                       'pic_meipt_count' => 31,
                       'pic_meigwctrl_mask' => '0x3',
                       'pic_offset' => '0xc0000',
                       'pic_meigwctrl_count' => 31,
                       'pic_meipt_offset' => '0x3004',
                       'pic_meie_mask' => '0x1',
                       'pic_meigwctrl_offset' => '0x4000',
                       'pic_base_addr' => '0xf00c0000',
                       'pic_region' => '0xf',
                       'pic_meigwclr_mask' => '0x0',
                       'pic_meigwclr_count' => 31,
                       'pic_meip_mask' => '0x0',
                       'pic_int_words' => 1,
                       'pic_total_int_plus1' => 32,
                       'pic_meipl_mask' => '0xf',
                       'pic_bits' => 15,
                       'pic_size' => 32,
                       'pic_meipt_mask' => '0x0',
                       'pic_meip_count' => 1,
                       'pic_meigwclr_offset' => '0x5000',
                       'pic_mpiccfg_mask' => '0x1',
                       'pic_mpiccfg_offset' => '0x3000',
                       'pic_meie_count' => 31,
                       'pic_total_int' => 31,
                       'pic_mpiccfg_count' => 1
                     },
            'target' => 'default',
            'btb' => {
                       'btb_btag_size' => 5,
                       'btb_index2_lo' => 10,
                       'btb_index3_hi' => 25,
                       'btb_fold2_index_hash' => 0,
                       'btb_size' => 512,
                       'btb_index3_lo' => 18,
                       'btb_index2_hi' => 17,
                       'btb_index1_lo' => '2',
                       'btb_toffset_size' => '12',
                       'btb_addr_lo' => '2',
                       'btb_array_depth' => 256,
                       'btb_btag_fold' => 0,
                       'btb_enable' => '1',
                       'btb_addr_hi' => 9,
                       'btb_index1_hi' => 9
                     },
            'nmi_vec' => '0x11110000',
            'protection' => {
                              'data_access_addr0' => '0x00000000',
                              'data_access_mask7' => '0xffffffff',
                              'data_access_mask4' => '0xffffffff',
                              'data_access_enable3' => '0x0',
                              'inst_access_enable2' => '0x0',
                              'inst_access_addr1' => '0x00000000',
                              'data_access_enable0' => '0x0',
                              'inst_access_addr2' => '0x00000000',
                              'inst_access_mask5' => '0xffffffff',
                              'data_access_enable1' => '0x0',
                              'data_access_mask6' => '0xffffffff',
                              'data_access_addr3' => '0x00000000',
                              'data_access_enable7' => '0x0',
                              'data_access_addr4' => '0x00000000',
                              'data_access_enable6' => '0x0',
                              'data_access_enable5' => '0x0',
                              'data_access_addr7' => '0x00000000',
                              'data_access_mask0' => '0xffffffff',
                              'inst_access_addr5' => '0x00000000',
                              'inst_access_mask2' => '0xffffffff',
                              'data_access_mask3' => '0xffffffff',
                              'data_access_addr6' => '0x00000000',
                              'data_access_enable4' => '0x0',
                              'inst_access_mask1' => '0xffffffff',
                              'data_access_addr1' => '0x00000000',
                              'inst_access_enable0' => '0x0',
                              'data_access_addr2' => '0x00000000',
                              'data_access_mask5' => '0xffffffff',
                              'inst_access_enable1' => '0x0',
                              'inst_access_addr3' => '0x00000000',
                              'inst_access_mask6' => '0xffffffff',
                              'inst_access_addr0' => '0x00000000',
                              'inst_access_mask7' => '0xffffffff',
                              'data_access_enable2' => '0x0',
                              'inst_access_mask4' => '0xffffffff',
                              'inst_access_enable3' => '0x0',
                              'inst_access_enable4' => '0x0',
                              'data_access_addr5' => '0x00000000',
                              'data_access_mask2' => '0xffffffff',
                              'inst_access_mask3' => '0xffffffff',
                              'inst_access_addr6' => '0x00000000',
                              'data_access_mask1' => '0xffffffff',
                              'inst_access_addr4' => '0x00000000',
                              'inst_access_enable7' => '0x0',
                              'inst_access_enable6' => '0x0',
                              'inst_access_enable5' => '0x0',
                              'inst_access_addr7' => '0x00000000',
                              'inst_access_mask0' => '0xffffffff'
                            }
          );
1;
