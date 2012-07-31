//////////////////////////////////////////////////////////////////////////////
//Copyright 2008
//  Andrew Gacek, Steven Holte, Gopalan Nadathur, Xiaochu Qi, Zach Snow
//////////////////////////////////////////////////////////////////////////////
// This file is part of Teyjus.                                             //
//                                                                          //
// Teyjus is free software: you can redistribute it and/or modify           //
// it under the terms of the GNU General Public License as published by     //
// the Free Software Foundation, either version 3 of the License, or        //
// (at your option) any later version.                                      //
//                                                                          //
// Teyjus is distributed in the hope that it will be useful,                //
// but WITHOUT ANY WARRANTY; without even the implied warranty of           //
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            //
// GNU General Public License for more details.                             //
//                                                                          //
// You should have received a copy of the GNU General Public License        //
// along with Teyjus.  If not, see <http://www.gnu.org/licenses/>.          //
//////////////////////////////////////////////////////////////////////////////
/*****************************************************************************/
/*                                                                           */
/* File siminstr.h. The instruction set of the virtual machine.              */
/*****************************************************************************/
#ifndef SIMINSTR_H
#define SIMINSTR_H

/*****************************************************************************/
/*  INSTRUCTIONS FOR UNIFYING AND CREATING TERMS                             */
/*****************************************************************************/

/**********************************************************/
/* PUT CLASS                                              */
/**********************************************************/
void SINSTR_put_variable_t();
void SINSTR_put_variable_te();
void SINSTR_put_variable_p();
void SINSTR_put_value_t();
void SINSTR_put_value_p();
void SINSTR_put_unsafe_value();
void SINSTR_copy_value();
void SINSTR_put_m_const();
void SINSTR_put_p_const();
void SINSTR_put_nil();
void SINSTR_put_integer();
void SINSTR_put_float();
void SINSTR_put_string();
void SINSTR_put_index();
void SINSTR_put_app();
void SINSTR_put_list();
void SINSTR_put_lambda();

/**********************************************************/
/* SET CLASS                                              */
/**********************************************************/
void SINSTR_set_variable_t();
void SINSTR_set_variable_te();
void SINSTR_set_variable_p();
void SINSTR_set_value_t();
void SINSTR_set_value_p();
void SINSTR_globalize_pt();
void SINSTR_globalize_t();
void SINSTR_set_m_const();
void SINSTR_set_p_const();
void SINSTR_set_nil();
void SINSTR_set_integer();
void SINSTR_set_float();
void SINSTR_set_string();
void SINSTR_set_index();
void SINSTR_set_void();
//needed?
void SINSTR_deref();
void SINSTR_set_lambda();

/**********************************************************/
/* GET CLASS                                              */
/**********************************************************/
void SINSTR_get_variable_t();
void SINSTR_get_variable_p();
void SINSTR_init_variable_t();
void SINSTR_init_variable_p();
void SINSTR_get_m_constant();
void SINSTR_get_p_constant();
void SINSTR_get_integer();
void SINSTR_get_float();
void SINSTR_get_string();
void SINSTR_get_nil();
void SINSTR_get_m_structure();
void SINSTR_get_p_structure();
void SINSTR_get_list();

/**********************************************************/
/* UNIFY CLASS                                            */
/**********************************************************/
void SINSTR_unify_variable_t();
void SINSTR_unify_variable_p();
void SINSTR_unify_value_t();
void SINSTR_unify_value_p();
void SINSTR_unify_local_value_t();
void SINSTR_unify_local_value_p();
void SINSTR_unify_m_constant();
void SINSTR_unify_p_constant();
void SINSTR_unify_nil();
void SINSTR_unify_integer();
void SINSTR_unify_float();
void SINSTR_unify_string();
void SINSTR_unify_void();

/*****************************************************************************/
/*   INSTRUCTIONS FOR UNIFYING AND CREATING TYPES                            */
/*****************************************************************************/

/**********************************************************/
/* PUT CLASS                                              */
/**********************************************************/
void SINSTR_put_type_variable_t();
void SINSTR_put_type_variable_p();
void SINSTR_put_type_value_t();
void SINSTR_put_type_value_p();
void SINSTR_put_type_unsafe_value();
void SINSTR_put_type_const();
void SINSTR_put_type_structure();
void SINSTR_put_type_arrow();

/**********************************************************/
/* SET CLASS                                              */
/**********************************************************/
void SINSTR_set_type_variable_t();
void SINSTR_set_type_variable_p();
void SINSTR_set_type_value_t();
void SINSTR_set_type_value_p();
void SINSTR_set_type_local_value_t();
void SINSTR_set_type_local_value_p();
void SINSTR_set_type_constant();

/**********************************************************/
/* GET CLASS                                              */
/**********************************************************/
void SINSTR_get_type_variable_t();
void SINSTR_get_type_variable_p();
void SINSTR_init_type_variable_t();
void SINSTR_init_type_variable_p();
void SINSTR_get_type_value_t();
void SINSTR_get_type_value_p();
void SINSTR_get_type_constant();
void SINSTR_get_type_structure();
void SINSTR_get_type_arrow();

/**********************************************************/
/* UNIFY CLASS                                            */
/**********************************************************/
void SINSTR_unify_type_variable_t();
void SINSTR_unify_type_variable_p();
void SINSTR_unify_type_value_t();
void SINSTR_unify_type_value_p();
void SINSTR_unify_envty_value_t();
void SINSTR_unify_envty_value_p();
void SINSTR_unify_type_local_value_t();
void SINSTR_unify_type_local_value_p();
void SINSTR_unify_envty_local_value_t();
void SINSTR_unify_envty_local_value_p();
void SINSTR_unify_type_constant();

/* init type var for implication goal */
void SINSTR_create_type_variable();

/*****************************************************************************/
/*   HIGHER-ORDER INSTRUCTIONS                                               */
/*****************************************************************************/
void SINSTR_pattern_unify_t();
void SINSTR_pattern_unify_p();
void SINSTR_finish_unify();
void SINSTR_head_normalize_t();
void SINSTR_head_normalize_p();

/*****************************************************************************/
/*   LOGICAL INSTRUCTIONS                                                    */
/*****************************************************************************/
void SINSTR_incr_universe();
void SINSTR_decr_universe();
void SINSTR_set_univ_tag();
void SINSTR_tag_exists_t();
void SINSTR_tag_exists_p();
void SINSTR_tag_variable();

void SINSTR_push_impl_point();
void SINSTR_pop_impl_point();
void SINSTR_add_imports();
void SINSTR_remove_imports();
void SINSTR_push_import();
void SINSTR_pop_imports();

/*****************************************************************************/
/*   CONTROL INSTRUCTIONS                                                    */
/*****************************************************************************/
void SINSTR_allocate();
void SINSTR_deallocate();
void SINSTR_call();
void SINSTR_call_name();
void SINSTR_execute();
void SINSTR_execute_name();
void SINSTR_proceed();

/*****************************************************************************/
/*   CHOICE INSTRUCTIONS                                                     */
/*****************************************************************************/
void SINSTR_try_me_else();
void SINSTR_retry_me_else();
void SINSTR_trust_me();
void SINSTR_try();
void SINSTR_retry();
void SINSTR_trust();
void SINSTR_trust_ext();
void SINSTR_try_else();
void SINSTR_retry_else();
void SINSTR_branch();

/*****************************************************************************/
/*   INDEXING INSTRUCTIONS                                                   */
/*****************************************************************************/
void SINSTR_switch_on_term();
void SINSTR_switch_on_constant();
void SINSTR_switch_on_bvar();
void SINSTR_switch_on_reg();

/*****************************************************************************/
/*   CUT INSTRUCTIONS                                                        */
/*****************************************************************************/
void SINSTR_neck_cut();
void SINSTR_get_level();
void SINSTR_put_level();
void SINSTR_cut();

/*****************************************************************************/
/*   MISCELLANEOUS INSTRUCTIONS                                              */
/*****************************************************************************/
void SINSTR_call_builtin();
void SINSTR_builtin();
void SINSTR_stop();
void SINSTR_halt();
void SINSTR_fail();

/**************************************************************************/
/*       linker only                                                      */
/**************************************************************************/
void SINSTR_execute_link_only();
void SINSTR_call_link_only();

#endif //SIMINSTR_H
