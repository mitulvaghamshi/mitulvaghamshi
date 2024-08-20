#include <errno.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifndef LISP_DEF_H
#define LISP_DEF_H

#define TRUE 0x1
#define FALSE 0x0

#define UNUSED __attribute((unused))

#define ERR_STR "Received [%i]; Expected [%i]"

#define LISP_BUILTINS_EMIT(f, c, o)                                            \
    LispVal *(f)(LispEnv * env, LispVal * val) { return (c)(env, val, o); }

#define LISP_ASSERT_EQ(v, l, r) LISP_ASSERT(val, l == r, ERR_STR, l, r);
#define LISP_ASSERT_NE(v, l, r) LISP_ASSERT(val, l != r, ERR_STR, l, r);
#define LISP_ASSERT_IS(v, l, r)                                                \
    LISP_ASSERT(v, l == r, ERR_STR, lisp_val_type_name(l),                     \
                lisp_val_type_name(r));
#define LISP_ASSERT(v, c, f, ...)                                              \
    if (!(c)) {                                                                \
        LispVal *e = lisp_val_err(f, ##__VA_ARGS__);                           \
        lisp_val_del(v);                                                       \
        return e;                                                              \
    }

#endif

#ifdef _WIN32

static char buffer[2048];

/* Fake readline function */
char *readline(char *prompt) {
    fputs(prompt, stdout);
    fgets(buffer, BUFFER_SIZE, stdin);
    char *buffer_copy = malloc(strlen(buffer) + 1);
    strcpy(buffer_copy, buffer);
    buffer_copy[strlen(buffer) - 1] = '\0';
    return buffer_copy;
}

/* Fake add_history function */
void add_history(char *unused) {}

#elif __APPLE__

#include <editline/readline.h>

#elif __unix__

#include <editline/history.h>
#include <editline/readline.h>

#else

#error "Unsupported platform"

#endif

#if defined(USE_MPC)

#include "mpc/mpc.h"

#endif

#ifndef LISP_DS_H
#define LISP_DS_H

struct LispVal;
struct LispEnv;

typedef struct LispVal LispVal;
typedef struct LispEnv LispEnv;

typedef char *LispStr;

typedef LispVal *(*LispFun)(LispEnv *env, LispVal *val);

typedef enum : unsigned {
    LISP_ERR = 0x0,
    LISP_NUM = 0x1,
    LISP_SYM = 0x2,
    LISP_STR = 0x3,
    LISP_FUN = 0x4,
    LISP_SXP = 0x5,
    LISP_QXP = 0x6
} LvType;

struct LispEnv {
    unsigned count;
    LispStr *syms;
    LispVal **vals;
    LispEnv *parent;
};

struct LispVal {
    LvType type;
    double num;
    LispStr err;
    LispStr sym;
    LispStr str;
    LispFun fun;
    LispEnv *env;
    LispVal *args;
    LispVal *body;
    LispVal **cell;
    unsigned count;
};

#endif

#ifndef LISP_FN_H
#define LISP_FN_H

void lisp_val_print(LispVal *val);
void lisp_val_print_expr(LispVal *val, char open, char close);
char *lisp_val_type_name(int type);

LispVal *lisp_val_num(double num);
LispVal *lisp_val_err(LispStr fmt, ...);
LispVal *lisp_val_sym(LispStr sym);
LispVal *lisp_val_str(LispStr str);
LispVal *lisp_val_fun(LispFun fun);
LispVal *lisp_val_sexpr(void);
LispVal *lisp_val_qexpr(void);

LispVal *lisp_val_lmd(LispVal *args, LispVal *body);
LispVal *lisp_val_add(LispVal *val, LispVal *x);
LispVal *lisp_val_pop(LispVal *val, unsigned i);
LispVal *lisp_val_take(LispVal *val, unsigned i);
LispVal *lisp_val_join(LispVal *val, LispVal *x);
LispVal *lisp_val_copy(LispVal *val);
int lisp_val_cmp(LispVal *x_val, LispVal *y_val);
void lisp_val_del(LispVal *val);

LispEnv *lisp_env_new(void);
LispEnv *lisp_env_copy(LispEnv *env);
LispVal *lisp_env_get(LispEnv *env, LispVal *val);
void lisp_env_def(LispEnv *env, LispVal *fun, LispVal *sym);
void lisp_env_put(LispEnv *env, LispVal *fun, LispVal *sym);
void lisp_env_del(LispEnv *env);

LispVal *lisp_val_eval(LispEnv *env, LispVal *val);
LispVal *lisp_val_eval_sexpr(LispEnv *env, LispVal *val);

#if defined(USE_MPC)

LispVal *lisp_val_read_expr(mpc_ast_t *t);

#else

LispVal *lisp_val_read_expr(LispStr input, int *i, char end);

#endif

LispVal *lisp_val_call(LispEnv *env, LispVal *f_val, LispVal *val);

void lisp_register_builtins(LispEnv *env);
void lisp_builtin_register(LispEnv *env, LispFun fun, LispStr op);

#if defined(USE_MPC)

LispVal *builtin_load(LispEnv *env, LispVal *val);

#else

LispVal *builtin_load(LispEnv *env, LispVal *val);

#endif

LispVal *builtin_print(LispEnv *env UNUSED, LispVal *val);
LispVal *builtin_error(LispEnv *env UNUSED, LispVal *val);

LispVal *builtin_lmd(LispEnv *env UNUSED, LispVal *val);
LispVal *builtin_def(LispEnv *env, LispVal *val);
LispVal *builtin_put(LispEnv *env, LispVal *val);

LispVal *builtin_list(LispEnv *env UNUSED, LispVal *val);
LispVal *builtin_head(LispEnv *env UNUSED, LispVal *val);
LispVal *builtin_tail(LispEnv *env UNUSED, LispVal *val);
LispVal *builtin_join(LispEnv *env UNUSED, LispVal *val);
LispVal *builtin_eval(LispEnv *env UNUSED, LispVal *val);

LispVal *builtin_add(LispEnv *env, LispVal *val);
LispVal *builtin_sub(LispEnv *env, LispVal *val);
LispVal *builtin_mul(LispEnv *env, LispVal *val);
LispVal *builtin_div(LispEnv *env, LispVal *val);
LispVal *builtin_mod(LispEnv *env, LispVal *val);

LispVal *builtin_not(LispEnv *env, LispVal *val);
LispVal *builtin_and(LispEnv *env, LispVal *val);
LispVal *builtin_or(LispEnv *env, LispVal *val);
LispVal *builtin_xor(LispEnv *env, LispVal *val);

LispVal *builtin_gt(LispEnv *env, LispVal *val);
LispVal *builtin_lt(LispEnv *env, LispVal *val);
LispVal *builtin_ge(LispEnv *env, LispVal *val);
LispVal *builtin_le(LispEnv *env, LispVal *val);
LispVal *builtin_eq(LispEnv *env, LispVal *val);
LispVal *builtin_ne(LispEnv *env, LispVal *val);

LispVal *builtin_deq(LispEnv *env, LispVal *val);
LispVal *builtin_dne(LispEnv *env, LispVal *val);
LispVal *builtin_if(LispEnv *env, LispVal *val);

LispVal *lisp_builtin_cal(LispEnv *env UNUSED, LispVal *val, LispStr op);
LispVal *lisp_builtin_btw(LispEnv *env UNUSED, LispVal *val, LispStr op);
LispVal *lisp_builtin_ord(LispEnv *env UNUSED, LispVal *val, LispStr op);
LispVal *lisp_builtin_equ(LispEnv *env UNUSED, LispVal *val, LispStr op);
LispVal *lisp_builtin_cmp(LispEnv *env, LispVal *val, LispStr op UNUSED);
LispVal *lisp_builtin_var(LispEnv *env, LispVal *val, LispStr op);

#if !defined(USE_MPC)

LispVal *lisp_val_read(LispStr input, int *i);
LispVal *lisp_val_read_sym(LispStr input, int *i);
LispVal *lisp_val_read_str(LispStr input, int *i);
void lisp_val_print_str(LispStr input);
char lisp_val_str_unescape(char c);
LispStr lisp_val_str_escape(char c);

#endif

#endif

#if defined(USE_MPC)

#define PARSER_COUNT 8

mpc_parser_t *PN;

#endif

int main(int argc, char **argv) {
    puts("Lisp Version 0.0.1 (q to quit).");

#if defined(USE_MPC)

    puts("Using MPC!");
    mpc_parser_t *Number = mpc_new("number");   // 1
    mpc_parser_t *Symbol = mpc_new("symbol");   // 2
    mpc_parser_t *String = mpc_new("string");   // 3
    mpc_parser_t *Comment = mpc_new("comment"); // 4
    mpc_parser_t *Sexpr = mpc_new("sexpr");     // 5
    mpc_parser_t *Qexpr = mpc_new("qexpr");     // 6
    mpc_parser_t *Expr = mpc_new("expr");       // 7
    PN = mpc_new("pn");                         // 8

    mpca_lang(MPCA_LANG_DEFAULT,
              " number  : /-?\\d+(\\.\\d+)?/                ; "
              " symbol  : /[a-zA-Z0-9_+\\-*\\/%\\\\=<>!&]+/ ; "
              " string  : /\"(\\\\.|[^\"])*\"/              ; "
              " comment : /;[^\\r\\n]*/                     ; "
              " sexpr   : '(' <expr>* ')'                   ; "
              " qexpr   : '{' <expr>* '}'                   ; "
              " expr    : <number> | <symbol> | <string>      "
              "         | <comment> | <sexpr> | <qexpr>     ; "
              " pn      : /^/ <expr>* /$/                   ; ",
              Number, Symbol, String, Comment, Sexpr, Qexpr, Expr, PN, NULL);

#endif

    LispEnv *env = lisp_env_new();
    lisp_register_builtins(env);

    if (argc > 1) {
        for (int i = 1; i < argc; i++) {
            LispVal *arg =
                lisp_val_add(lisp_val_sexpr(), lisp_val_str(argv[i]));
            LispVal *res = builtin_load(env, arg);
            if (res->type == LISP_ERR) {
                lisp_val_print(res);
                putchar('\n');
            }
            lisp_val_del(res);
        }
    }

    while (TRUE) {
        char *buffer = readline("lisp> ");
        if (strcmp(buffer, "q") == 0) {
            free(buffer);
            break;
        }
        add_history(buffer);

#if defined(USE_MPC)

        mpc_result_t res;
        if (mpc_parse("<stdin>", buffer, PN, &res)) {
            LispVal *x = lisp_val_eval(env, lisp_val_read_expr(res.output));
            lisp_val_print(x);
            putchar('\n');
            lisp_val_del(x);
            mpc_ast_delete(res.output);
        } else {
            mpc_err_print(res.error);
            mpc_err_delete(res.error);
        }

#else

        int pos = 0;
        LispVal *expr = lisp_val_read_expr(buffer, &pos, '\0');
        LispVal *x = lisp_val_eval(env, expr);
        lisp_val_print(x);
        putchar('\n');
        lisp_val_del(x);

#endif

        free(buffer);
    }

    clear_history();
    lisp_env_del(env);

#if defined(USE_MPC)

    mpc_cleanup(PARSER_COUNT, Number, Symbol, String, Comment, Sexpr, Qexpr,
                Expr, PN);

#endif

    return 0;
}

void lisp_val_print(LispVal *val) {
    switch (val->type) {
    case LISP_NUM: {
        printf("%0.2lf", val->num);
    } break;
    case LISP_ERR: {
        printf("%s", val->err);
    } break;
    case LISP_SYM: {
        printf("%s", val->sym);
    } break;
    case LISP_STR: {

#if defined(USE_MPC)

        char *escaped = malloc(strlen(val->str) + 1);
        strcpy(escaped, val->str);
        escaped = mpcf_escape(escaped);
        printf("\"%s\"", escaped);
        free(escaped);

#else

        lisp_val_print_str(val->str);

#endif

    } break;
    case LISP_FUN: {
        if (val->fun) {
            printf("<Fn>");
        } else {
            printf("(\\ ");
            lisp_val_print(val->args);
            putchar(' ');
            lisp_val_print(val->body);
            putchar(')');
        }
    } break;
    case LISP_SXP: {
        lisp_val_print_expr(val, '(', ')');
    } break;
    case LISP_QXP: {
        lisp_val_print_expr(val, '{', '}');
    } break;
    }
}

void lisp_val_print_expr(LispVal *val, char open, char close) {
    putchar(open);
    for (unsigned i = 0; i < val->count; i++) {
        lisp_val_print(val->cell[i]);
        if (i != (val->count - 1)) {
            putchar(' ');
        }
    }
    putchar(close);
}

char *lisp_val_type_name(int type) {
    switch (type) {
    case LISP_NUM:
        return "Number";
    case LISP_ERR:
        return "Error";
    case LISP_SYM:
        return "Symbol";
    case LISP_STR:
        return "String";
    case LISP_FUN:
        return "Function";
    case LISP_SXP:
        return "S-Expression";
    case LISP_QXP:
        return "Q-Expression";
    default:
        return "Unknown";
    }
}

LispVal *lisp_val_num(double num) {
    LispVal *val = malloc(sizeof(LispVal));
    val->type = LISP_NUM;
    val->num = num;
    return val;
}

LispVal *lisp_val_err(LispStr fmt, ...) {
    LispVal *val = malloc(sizeof(LispVal));
    val->type = LISP_ERR;
    unsigned buf_size = 1024;
    va_list va;
    va_start(va, fmt);
    val->err = malloc(buf_size);
    vsnprintf(val->err, buf_size - 1, fmt, va);
    val->err = realloc(val->err, strlen(val->err) + 1);
    va_end(va);
    return val;
}

LispVal *lisp_val_sym(LispStr sym) {
    LispVal *val = malloc(sizeof(LispVal));
    val->type = LISP_SYM;
    val->sym = malloc(strlen(sym) + 1);
    strcpy(val->sym, sym);
    return val;
}

LispVal *lisp_val_str(LispStr str) {
    LispVal *val = malloc(sizeof(LispVal));
    val->type = LISP_STR;
    val->str = malloc(strlen(str) + 1);
    strcpy(val->str, str);
    return val;
}

LispVal *lisp_val_fun(LispFun fun) {
    LispVal *val = malloc(sizeof(LispVal));
    val->type = LISP_FUN;
    val->fun = fun;
    return val;
}

LispVal *lisp_val_sexpr(void) {
    LispVal *val = malloc(sizeof(LispVal));
    val->type = LISP_SXP;
    val->count = 0;
    val->cell = NULL;
    return val;
}

LispVal *lisp_val_qexpr(void) {
    LispVal *val = malloc(sizeof(LispVal));
    val->type = LISP_QXP;
    val->count = 0;
    val->cell = NULL;
    return val;
}

LispVal *lisp_val_lmd(LispVal *args, LispVal *body) {
    LispVal *val = malloc(sizeof(LispVal));
    val->type = LISP_FUN;
    val->fun = NULL;
    val->env = lisp_env_new();
    val->args = args;
    val->body = body;
    return val;
}

LispVal *lisp_val_add(LispVal *val, LispVal *x) {
    val->count++;
    val->cell = realloc(val->cell, sizeof(LispVal) * val->count);
    val->cell[val->count - 1] = x;
    return val;
}

LispVal *lisp_val_pop(LispVal *val, unsigned i) {
    LispVal *x = val->cell[i];
    memmove(&val->cell[i], &val->cell[i + 1],
            sizeof(LispVal) * (val->count - i - 1));
    val->count--;
    val->cell = realloc(val->cell, sizeof(LispVal) * val->count);
    return x;
}

LispVal *lisp_val_take(LispVal *val, unsigned i) {
    LispVal *x = lisp_val_pop(val, i);
    lisp_val_del(val);
    return x;
}

LispVal *lisp_val_join(LispVal *val, LispVal *x) {
    for (unsigned i = 0; i < x->count; i++) {
        val = lisp_val_add(val, x->cell[i]);
    }
    free(x->cell);
    free(x);
    return val;
}

LispVal *lisp_val_copy(LispVal *val) {
    LispVal *x = malloc(sizeof(LispVal));
    x->type = val->type;
    switch (val->type) {
    case LISP_NUM: {
        x->num = val->num;
    } break;
    case LISP_ERR: {
        x->err = malloc(strlen(val->err) + 1);
        strcpy(x->err, val->err);
    } break;
    case LISP_SYM: {
        x->sym = malloc(strlen(val->sym) + 1);
        strcpy(x->sym, val->sym);
    } break;
    case LISP_STR: {
        x->str = malloc(strlen(val->str) + 1);
        strcpy(x->str, val->str);
    } break;
    case LISP_FUN: {
        if (val->fun) {
            x->fun = val->fun;
        } else {
            x->fun = NULL;
            x->env = lisp_env_copy(val->env);
            x->args = lisp_val_copy(val->args);
            x->body = lisp_val_copy(val->body);
        }
    } break;
    case LISP_SXP:
    case LISP_QXP: {
        x->count = val->count;
        x->cell = malloc(sizeof(LispVal) * val->count);
        for (unsigned i = 0; i < x->count; i++) {
            x->cell[i] = lisp_val_copy(val->cell[i]);
        }
    } break;
    }
    return x;
}

int lisp_val_cmp(LispVal *x_val, LispVal *y_val) {
    if (x_val->type != y_val->type) {
        return 0;
    }
    switch (x_val->type) {
    case LISP_NUM: {
        return (x_val->num == y_val->num);
    } break;
    case LISP_ERR: {
        return (strcmp(x_val->err, y_val->err) == 0);
    } break;
    case LISP_SYM: {
        return (strcmp(x_val->sym, y_val->sym) == 0);
    } break;
    case LISP_STR: {
        return (strcmp(x_val->str, y_val->str) == 0);
    } break;
    case LISP_FUN: {
        if (x_val->fun || y_val->fun) {
            return x_val->fun == y_val->fun;
        }
        return (lisp_val_cmp(x_val->args, y_val->args) &&
                lisp_val_cmp(x_val->body, y_val->body));
    } break;
    case LISP_SXP:
    case LISP_QXP: {
        if (x_val->count != y_val->count) {
            return 0;
        }
        for (unsigned i = 0; i < x_val->count; i++) {
            if (!lisp_val_cmp(x_val->cell[i], y_val->cell[i])) {
                return 0;
            }
        }
        return 1;
    } break;
    }
    return 0;
}

void lisp_val_del(LispVal *val) {
    switch (val->type) {
    case LISP_NUM: {
    } break;
    case LISP_ERR: {
        free(val->err);
    } break;
    case LISP_SYM: {
        free(val->sym);
    } break;
    case LISP_STR: {
        free(val->str);
    } break;
    case LISP_FUN: {
        if (!val->fun) {
            lisp_env_del(val->env);
            lisp_val_del(val->args);
            lisp_val_del(val->body);
        }
    } break;
    case LISP_SXP:
    case LISP_QXP: {
        for (unsigned i = 0; i < val->count; i++) {
            lisp_val_del(val->cell[i]);
        }
        free(val->cell);
    } break;
    }
    free(val);
}

LispEnv *lisp_env_new(void) {
    LispEnv *env = malloc(sizeof(LispEnv));
    env->count = 0;
    env->syms = NULL;
    env->vals = NULL;
    env->parent = NULL;
    return env;
}

LispEnv *lisp_env_copy(LispEnv *env) {
    LispEnv *x = malloc(sizeof(LispEnv));
    x->count = env->count;
    x->parent = env->parent;

    x->syms = malloc(sizeof(char *) * env->count);
    x->vals = malloc(sizeof(LispVal) * env->count);

    for (unsigned i = 0; i < env->count; i++) {
        x->syms[i] = malloc(strlen(env->syms[i]) + 1);
        strcpy(x->syms[i], env->syms[i]);
        x->vals[i] = lisp_val_copy(env->vals[i]);
    }
    return x;
}

LispVal *lisp_env_get(LispEnv *env, LispVal *val) {
    for (unsigned i = 0; i < env->count; i++) {
        if (strcmp(env->syms[i], val->sym) == 0) {
            return lisp_val_copy(env->vals[i]);
        }
    }
    return env->parent ? lisp_env_get(env->parent, val)
                       : lisp_val_err("Unbound Symbol '%s'", val->sym);
}

void lisp_env_def(LispEnv *env, LispVal *fun, LispVal *sym) {
    while (env->parent) {
        env = env->parent;
    }
    lisp_env_put(env, fun, sym);
}

void lisp_env_put(LispEnv *env, LispVal *fun, LispVal *sym) {
    for (unsigned i = 0; i < env->count; i++) {
        if (strcmp(env->syms[i], sym->sym) == 0) {
            lisp_val_del(env->vals[i]);
            env->vals[i] = lisp_val_copy(fun);
            return;
        }
    }

    env->count++;

    env->syms = realloc(env->syms, sizeof(LispStr) * env->count);
    env->syms[env->count - 1] = malloc(strlen(sym->sym) + 1);
    strcpy(env->syms[env->count - 1], sym->sym);

    env->vals = realloc(env->vals, sizeof(LispVal) * env->count);
    env->vals[env->count - 1] = lisp_val_copy(fun);
}

void lisp_env_del(LispEnv *env) {
    for (unsigned i = 0; i < env->count; i++) {
        free(env->syms[i]);
        lisp_val_del(env->vals[i]);
    }
    free(env->syms);
    free(env->vals);
    free(env);
}

LispVal *lisp_val_eval(LispEnv *env, LispVal *val) {
    if (val->type == LISP_SYM) {
        LispVal *x = lisp_env_get(env, val);
        lisp_val_del(val);
        return x;
    }
    if (val->type == LISP_SXP) {
        return lisp_val_eval_sexpr(env, val);
    }
    return val;
}

LispVal *lisp_val_eval_sexpr(LispEnv *env, LispVal *val) {
    for (unsigned i = 0; i < val->count; i++) {
        val->cell[i] = lisp_val_eval(env, val->cell[i]);
    }

    for (unsigned i = 0; i < val->count; i++) {
        if (val->cell[i]->type == LISP_ERR) {
            return lisp_val_take(val, i);
        }
    }

    if (val->count == 0) {
        return val;
    } else if (val->count == 1) {
        return lisp_val_eval(env, lisp_val_take(val, 0));
    }

    LispVal *fun = lisp_val_pop(val, 0);
    if (fun->type != LISP_FUN) {
        LispVal *err = lisp_val_err(ERR_STR, lisp_val_type_name(fun->type),
                                    lisp_val_type_name(LISP_FUN));
        lisp_val_del(fun);
        lisp_val_del(val);
        return err;
    }

    LispVal *res = lisp_val_call(env, fun, val);
    lisp_val_del(fun);
    return res;
}

#if defined(USE_MPC)

LispVal *lisp_val_read_expr(mpc_ast_t *t) {
    if (strstr(t->tag, "number")) {
        errno = 0;
        double x = strtod(t->contents, NULL);
        if (errno == ERANGE) {
            return lisp_val_err("Result too large!");
        }
        return lisp_val_num(x);
    }

    if (strstr(t->tag, "symbol")) {
        return lisp_val_sym(t->contents);
    }

    if (strstr(t->tag, "string")) {
        t->contents[strlen(t->contents) - 1] = '\0';
        char *unescaped = malloc(strlen(t->contents + 1) + 1);
        strcpy(unescaped, t->contents + 1);
        unescaped = mpcf_unescape(unescaped);
        LispVal *val = lisp_val_str(unescaped);
        free(unescaped);
        return val;
    }

    LispVal *x = NULL;

    if (strcmp(t->tag, ">") == 0 || strstr(t->tag, "sexpr")) {
        x = lisp_val_sexpr();
    } else if (strstr(t->tag, "qexpr")) {
        x = lisp_val_qexpr();
    }

    for (int i = 0; i < t->children_num; i++) {
        if (strcmp(t->children[i]->contents, "(") == 0 ||
            strcmp(t->children[i]->contents, ")") == 0 ||
            strcmp(t->children[i]->contents, "{") == 0 ||
            strcmp(t->children[i]->contents, "}") == 0 ||
            strcmp(t->children[i]->tag, "regex") == 0 ||
            strstr(t->children[i]->tag, "comment")) {
            continue;
        }
        x = lisp_val_add(x, lisp_val_read_expr(t->children[i]));
    }
    return x;
}

#else

LispVal *lisp_val_read_expr(LispStr input, int *i, char end) {
    LispVal *x = (end == '}') ? lisp_val_qexpr() : lisp_val_sexpr();
    while (input[*i] != end) {
        LispVal *y = lisp_val_read(input, i);
        if (y->type == LISP_ERR) {
            lisp_val_del(x);
            return y;
        }
        lisp_val_add(x, y);
    }
    (*i)++;
    return x;
}

#endif

LispVal *lisp_val_call(LispEnv *env, LispVal *fun, LispVal *val) {
    if (fun->fun) {
        return fun->fun(env, val);
    }

    while (val->count) {
        LISP_ASSERT(val, fun->args->count != 0, ERR_STR, val->count,
                    fun->args->count);

        LispVal *s_val = lisp_val_pop(fun->args, 0);

        if (strcmp(s_val->sym, "&") == 0) {
            LISP_ASSERT_EQ(val, fun->args->count, 1);

            LispVal *n_sym = lisp_val_pop(fun->args, 0);
            lisp_env_put(fun->env, builtin_list(env, val), n_sym);
            lisp_val_del(s_val);
            lisp_val_del(n_sym);
            break;
        }

        LispVal *x_val = lisp_val_pop(val, 0);
        lisp_env_put(fun->env, x_val, s_val);
        lisp_val_del(s_val);
        lisp_val_del(x_val);
    }

    lisp_val_del(val);

    if (fun->args->count > 0 && strcmp(fun->args->cell[0]->sym, "&") == 0) {
        LISP_ASSERT_EQ(lisp_val_num(0), fun->args->count, 2);

        lisp_val_del(lisp_val_pop(fun->args, 0));

        LispVal *n_sym = lisp_val_pop(fun->args, 0);
        LispVal *q_val = lisp_val_qexpr();

        lisp_env_put(fun->env, q_val, n_sym);
        lisp_val_del(n_sym);
        lisp_val_del(q_val);
    }

    if (fun->args->count > 0) {
        return lisp_val_copy(fun);
    }

    fun->env->parent = env;
    return builtin_eval(
        fun->env, lisp_val_add(lisp_val_sexpr(), lisp_val_copy(fun->body)));
}

void lisp_register_builtins(LispEnv *env) {
    lisp_builtin_register(env, builtin_load, "load");
    lisp_builtin_register(env, builtin_print, "print");
    lisp_builtin_register(env, builtin_error, "error");

    lisp_builtin_register(env, builtin_def, "def");
    lisp_builtin_register(env, builtin_put, "=");
    lisp_builtin_register(env, builtin_lmd, "\\");

    lisp_builtin_register(env, builtin_list, "list");
    lisp_builtin_register(env, builtin_head, "head");
    lisp_builtin_register(env, builtin_tail, "tail");
    lisp_builtin_register(env, builtin_join, "join");
    lisp_builtin_register(env, builtin_eval, "eval");

    lisp_builtin_register(env, builtin_add, "+");
    lisp_builtin_register(env, builtin_sub, "-");
    lisp_builtin_register(env, builtin_mul, "*");
    lisp_builtin_register(env, builtin_div, "/");
    lisp_builtin_register(env, builtin_mod, "%");

    lisp_builtin_register(env, builtin_not, "not");
    lisp_builtin_register(env, builtin_and, "and");
    lisp_builtin_register(env, builtin_or, "or");
    lisp_builtin_register(env, builtin_xor, "xor");

    lisp_builtin_register(env, builtin_gt, ">");
    lisp_builtin_register(env, builtin_lt, "<");
    lisp_builtin_register(env, builtin_ge, ">=");
    lisp_builtin_register(env, builtin_le, "<=");
    lisp_builtin_register(env, builtin_eq, "==");
    lisp_builtin_register(env, builtin_ne, "!=");

    lisp_builtin_register(env, builtin_deq, "===");
    lisp_builtin_register(env, builtin_dne, "!==");
    lisp_builtin_register(env, builtin_if, "if");
}

void lisp_builtin_register(LispEnv *env, LispFun fun, LispStr op) {
    LispVal *v_fun = lisp_val_fun(fun);
    LispVal *v_sym = lisp_val_sym(op);
    lisp_env_put(env, v_fun, v_sym);
    lisp_val_del(v_sym);
    lisp_val_del(v_fun);
}

#if defined(USE_MPC)

LispVal *builtin_load(LispEnv *env, LispVal *val) {
    LISP_ASSERT_EQ(val, val->count, 1);
    LISP_ASSERT_IS(val, val->cell[0]->type, LISP_STR);

    mpc_result_t res;
    if (mpc_parse_contents(val->cell[0]->str, PN, &res)) {
        LispVal *expr = lisp_val_read_expr(res.output);
        mpc_ast_delete(res.output);
        while (expr->count) {
            LispVal *x = lisp_val_eval(env, lisp_val_pop(expr, 0));
            if (x->type == LISP_ERR) {
                lisp_val_print(x);
                putchar('\n');
            }
            lisp_val_del(x);
        }
        lisp_val_del(expr);
        lisp_val_del(val);
        return lisp_val_sexpr();
    } else {
        char *e_str = mpc_err_string(res.error);
        mpc_err_delete(res.error);
        LispVal *err = lisp_val_err("Unable to load library %s", e_str);
        free(e_str);
        lisp_val_del(val);
        return err;
    }
}

#else

LispVal *builtin_load(LispEnv *env, LispVal *val) {
    LISP_ASSERT_EQ(val, val->count, 1);
    LISP_ASSERT_IS(val, val->cell[0]->type, LISP_STR);

    FILE *file = fopen(val->cell[0]->str, "rb");
    if (!file) {
        LispVal *err =
            lisp_val_err("Unable to load library %s", val->cell[0]->str);
        lisp_val_del(val);
        return err;
    }

    fseek(file, 0, SEEK_END);
    long count = ftell(file);
    fseek(file, 0, SEEK_SET);
    LispStr buffer = calloc(count + 1, 1);
    fread(buffer, 1, count, file);
    fclose(file);

    int pos = 0;
    LispVal *expr = lisp_val_read_expr(buffer, &pos, '\0');
    free(buffer);

    if (expr->type == LISP_ERR) {
        lisp_val_print(expr);
        putchar('\n');
    } else {
        while (expr->count) {
            LispVal *x = lisp_val_eval(env, lisp_val_pop(expr, 0));
            if (x->type == LISP_ERR) {
                lisp_val_print(x);
                putchar('\n');
            }
            lisp_val_del(x);
        }
    }

    lisp_val_del(expr);
    lisp_val_del(val);
    return lisp_val_sexpr();
}

#endif

LispVal *builtin_print(LispEnv *env UNUSED, LispVal *val) {
    for (unsigned i = 0; i < val->count; i++) {
        lisp_val_print(val->cell[i]);
        putchar(' ');
    }
    putchar('\n');
    lisp_val_del(val);
    return lisp_val_sexpr();
}

LispVal *builtin_error(LispEnv *env UNUSED, LispVal *val) {
    LISP_ASSERT_EQ(val, val->count, 1);
    LISP_ASSERT_IS(val, val->cell[0]->type, LISP_STR);

    LispVal *err = lisp_val_err(val->cell[0]->str);
    lisp_val_del(val);
    return err;
}

LispVal *builtin_lmd(LispEnv *env UNUSED, LispVal *val) {
    LISP_ASSERT_EQ(val, val->count, 2);
    LISP_ASSERT_IS(val, val->cell[0]->type, LISP_QXP);
    LISP_ASSERT_IS(val, val->cell[1]->type, LISP_QXP);

    for (unsigned i = 0; i < val->cell[0]->count; i++) {
        LISP_ASSERT_IS(val, val->cell[0]->cell[i]->type, LISP_SYM);
    }

    LispVal *args = lisp_val_pop(val, 0);
    LispVal *body = lisp_val_pop(val, 0);
    lisp_val_del(val);
    return lisp_val_lmd(args, body);
}

LispVal *builtin_list(LispEnv *env UNUSED, LispVal *val) {
    val->type = LISP_QXP;
    return val;
}

LispVal *builtin_head(LispEnv *env UNUSED, LispVal *val) {
    LISP_ASSERT_EQ(val, val->count, 1);
    LISP_ASSERT_IS(val, val->cell[0]->type, LISP_QXP);
    LISP_ASSERT_NE(val, val->cell[0]->count, 0);

    LispVal *x = lisp_val_take(val, 0);
    while (x->count > 1) {
        lisp_val_del(lisp_val_pop(x, 1));
    }
    return x;
}

LispVal *builtin_tail(LispEnv *env UNUSED, LispVal *val) {
    LISP_ASSERT_EQ(val, val->count, 1);
    LISP_ASSERT_IS(val, val->cell[0]->type, LISP_QXP);
    LISP_ASSERT_NE(val, val->cell[0]->count, 0);

    LispVal *x = lisp_val_take(val, 0);
    lisp_val_del(lisp_val_pop(x, 0));
    return x;
}

LispVal *builtin_join(LispEnv *env UNUSED, LispVal *val) {
    for (unsigned i = 0; i < val->count; i++) {
        LISP_ASSERT_IS(val, val->cell[i]->type, LISP_QXP);
    }

    LispVal *x = lisp_val_pop(val, 0);
    while (val->count) {
        x = lisp_val_join(x, lisp_val_pop(val, 0));
    }
    lisp_val_del(val);
    return x;
}

LispVal *builtin_eval(LispEnv *env, LispVal *val) {
    LISP_ASSERT_EQ(val, val->count, 1);
    LISP_ASSERT_IS(val, val->cell[0]->type, LISP_QXP);

    LispVal *x = lisp_val_take(val, 0);
    x->type = LISP_SXP;
    return lisp_val_eval(env, x);
}

LISP_BUILTINS_EMIT(builtin_def, lisp_builtin_var, "def");
LISP_BUILTINS_EMIT(builtin_put, lisp_builtin_var, "=");

LISP_BUILTINS_EMIT(builtin_add, lisp_builtin_cal, "+");
LISP_BUILTINS_EMIT(builtin_sub, lisp_builtin_cal, "-");
LISP_BUILTINS_EMIT(builtin_mul, lisp_builtin_cal, "*");
LISP_BUILTINS_EMIT(builtin_div, lisp_builtin_cal, "/");
LISP_BUILTINS_EMIT(builtin_mod, lisp_builtin_cal, "%");

LISP_BUILTINS_EMIT(builtin_not, lisp_builtin_btw, "not");
LISP_BUILTINS_EMIT(builtin_and, lisp_builtin_btw, "and");
LISP_BUILTINS_EMIT(builtin_or, lisp_builtin_btw, "or");
LISP_BUILTINS_EMIT(builtin_xor, lisp_builtin_btw, "xor");

LISP_BUILTINS_EMIT(builtin_gt, lisp_builtin_ord, ">");
LISP_BUILTINS_EMIT(builtin_lt, lisp_builtin_ord, "<");
LISP_BUILTINS_EMIT(builtin_ge, lisp_builtin_ord, ">=");
LISP_BUILTINS_EMIT(builtin_le, lisp_builtin_ord, "<=");
LISP_BUILTINS_EMIT(builtin_eq, lisp_builtin_ord, "==");
LISP_BUILTINS_EMIT(builtin_ne, lisp_builtin_ord, "!=");

LISP_BUILTINS_EMIT(builtin_deq, lisp_builtin_equ, "===");
LISP_BUILTINS_EMIT(builtin_dne, lisp_builtin_equ, "!==");
LISP_BUILTINS_EMIT(builtin_if, lisp_builtin_cmp, "if");

LispVal *lisp_builtin_cal(LispEnv *env UNUSED, LispVal *val, LispStr op) {
    for (unsigned i = 0; i < val->count; i++) {
        LISP_ASSERT_IS(val, val->cell[i]->type, LISP_NUM);
    }

    LispVal *x = lisp_val_pop(val, 0);
    if ((strcmp(op, "-") == 0) && val->count == 0) {
        x->num = -x->num;
    }

    while (val->count > 0) {
        LispVal *y = lisp_val_pop(val, 0);
        if (strcmp(op, "+") == 0) {
            x->num += y->num;
        } else if (strcmp(op, "-") == 0) {
            x->num -= y->num;
        } else if (strcmp(op, "*") == 0) {
            x->num *= y->num;
        } else if (y->num == 0) {
            lisp_val_del(x);
            lisp_val_del(y);
            x = lisp_val_err("Infinity!");
            break;
        } else if (strcmp(op, "/") == 0) {
            x->num /= y->num;
        } else if (strcmp(op, "%") == 0) {
            x->num -= ((int)(x->num / y->num) * y->num);
        }
        lisp_val_del(y);
    }

    lisp_val_del(val);
    return x;
}

LispVal *lisp_builtin_btw(LispEnv *env UNUSED, LispVal *val, LispStr op) {
    int res = 0;
    if (strcmp(op, "not") == 0) {
        LISP_ASSERT_EQ(val, val->count, 1);
        LISP_ASSERT_IS(val, val->cell[0]->type, LISP_NUM);
        res = ~((int)val->cell[0]->num);
    } else {
        LISP_ASSERT_EQ(val, val->count, 2);
        LISP_ASSERT_IS(val, val->cell[0]->type, LISP_NUM);
        LISP_ASSERT_IS(val, val->cell[1]->type, LISP_NUM);
        if (strcmp(op, "and") == 0) {
            res = ((int)val->cell[0]->num) & ((int)val->cell[1]->num);
        } else if (strcmp(op, "or") == 0) {
            res = ((int)val->cell[0]->num) | ((int)val->cell[1]->num);
        } else if (strcmp(op, "xor") == 0) {
            res = ((int)val->cell[0]->num) ^ ((int)val->cell[1]->num);
        }
    }

    lisp_val_del(val);
    return lisp_val_num(res);
}

LispVal *lisp_builtin_ord(LispEnv *env UNUSED, LispVal *val, LispStr op) {
    LISP_ASSERT_EQ(val, val->count, 2);
    LISP_ASSERT_IS(val, val->cell[0]->type, LISP_NUM);
    LISP_ASSERT_IS(val, val->cell[1]->type, LISP_NUM);

    int res = -1;
    if (strcmp(op, ">") == 0) {
        res = val->cell[0]->num > val->cell[1]->num;
    } else if (strcmp(op, "<") == 0) {
        res = val->cell[0]->num < val->cell[1]->num;
    } else if (strcmp(op, ">=") == 0) {
        res = val->cell[0]->num >= val->cell[1]->num;
    } else if (strcmp(op, "<=") == 0) {
        res = val->cell[0]->num <= val->cell[1]->num;
    } else if (strcmp(op, "==") == 0) {
        res = val->cell[0]->num == val->cell[1]->num;
    } else if (strcmp(op, "!=") == 0) {
        res = val->cell[0]->num != val->cell[1]->num;
    }

    lisp_val_del(val);
    return lisp_val_num(res);
}

LispVal *lisp_builtin_equ(LispEnv *env UNUSED, LispVal *val, LispStr op) {
    LISP_ASSERT_EQ(val, val->count, 2);

    int res = -1;
    if (strcmp(op, "===") == 0) {
        res = lisp_val_cmp(val->cell[0], val->cell[1]);
    } else if (strcmp(op, "!==") == 0) {
        res = !lisp_val_cmp(val->cell[0], val->cell[1]);
    }

    lisp_val_del(val);
    return lisp_val_num(res);
}

LispVal *lisp_builtin_cmp(LispEnv *env, LispVal *val, LispStr op UNUSED) {
    LISP_ASSERT_EQ(val, val->count, 3);
    LISP_ASSERT_IS(val, val->cell[0]->type, LISP_NUM);
    LISP_ASSERT_IS(val, val->cell[1]->type, LISP_QXP);
    LISP_ASSERT_IS(val, val->cell[2]->type, LISP_QXP);

    val->cell[1]->type = LISP_SXP;
    val->cell[2]->type = LISP_SXP;

    LispVal *res =
        lisp_val_eval(env, lisp_val_pop(val, (val->cell[0]->num) ? 1 : 2));
    lisp_val_del(val);
    return res;
}

LispVal *lisp_builtin_var(LispEnv *env, LispVal *val, LispStr op) {
    LISP_ASSERT_IS(val, val->cell[0]->type, LISP_QXP);

    LispVal *syms = val->cell[0];
    for (unsigned i = 0; i < syms->count; i++) {
        LISP_ASSERT_IS(val, syms->cell[i]->type, LISP_SYM);
    }

    LISP_ASSERT_EQ(val, syms->count, val->count - 1);

    for (unsigned i = 0; i < syms->count; i++) {
        if (strcmp(op, "def") == 0) {
            lisp_env_def(env, val->cell[i + 1], syms->cell[i]);
        }
        if (strcmp(op, "=") == 0) {
            lisp_env_put(env, val->cell[i + 1], syms->cell[i]);
        }
    }
    lisp_val_del(val);
    return lisp_val_sexpr();
}

#if !USE_MPC

LispVal *lisp_val_read(LispStr str, int *i) {
    while (strchr(" \t\v\r\n;", str[*i]) && str[*i] != '\0') {
        if (str[*i] == ';') {
            while (str[*i] != '\n' && str[*i] != '\0') {
                (*i)++;
            }
        }
        (*i)++;
    }

    LispVal *x = NULL;

    if (str[*i] == '\0') {
        return lisp_val_err("Unexpected end of input");
    } else if (str[*i] == '(') {
        (*i)++;
        x = lisp_val_read_expr(str, i, ')');
    } else if (str[*i] == '{') {
        (*i)++;
        x = lisp_val_read_expr(str, i, '}');
    } else if (strchr("abcdefghijklmnopqrstuvwxyz"
                      "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                      "0123456789_+-*\\/=<>!&",
                      str[*i])) {
        x = lisp_val_read_sym(str, i);
    } else if (strchr("\"", str[*i])) {
        x = lisp_val_read_str(str, i);
    } else {
        x = lisp_val_err("Unknown character %c", str[*i]);
    }

    while (strchr(" \t\v\r\n;", str[*i]) && str[*i] != '\0') {
        if (str[*i] == ';') {
            while (str[*i] != '\n' && str[*i] != '\0') {
                (*i)++;
            }
        }
        (*i)++;
    }

    return x;
}

LispVal *lisp_val_read_sym(LispStr input, int *i) {
    LispStr slice = calloc(1, 1);

    while (strchr("abcdefghijklmnopqrstuvwxyz"
                  "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                  "0123456789_+-*\\/=<>!&",
                  input[*i]) &&
           input[*i] != '\0') {
        slice = realloc(slice, strlen(slice) + 2);
        slice[strlen(slice) + 1] = '\0';
        slice[strlen(slice) + 0] = input[*i];
        (*i)++;
    }

    int is_num = strchr("-0123456789", slice[0]) != NULL;
    for (unsigned j = 1; j < strlen(slice); j++) {
        if (strchr("0123456789", slice[j]) == NULL) {
            is_num = 0;
            break;
        }
    }

    if (strlen(slice) == 1 && slice[0] == '-') {
        is_num = 0;
    }

    LispVal *x = NULL;

    if (is_num) {
        errno = 0;
        double d = strtod(slice, NULL);
        x = (errno != ERANGE) ? lisp_val_num(d)
                              : lisp_val_err("Invalid number %s", slice);
    } else {
        x = lisp_val_sym(slice);
    }

    free(slice);
    return x;
}

LispVal *lisp_val_read_str(LispStr input, int *i) {
    LispStr slice = calloc(1, 1);

    (*i)++;
    while (input[*i] != '"') {
        char c = input[*i];

        if (c == '\0') {
            free(slice);
            return lisp_val_err("Unexpected end of input at string literal");
        }

        if (c == '\\') {
            (*i)++;
            if (strchr("abfnrtv\\\'\"", input[*i])) {
                c = lisp_val_str_unescape(input[*i]);
            } else {
                free(slice);
                return lisp_val_err("Invalid escape character \\%c", input[*i]);
            }
        }

        slice = realloc(slice, strlen(slice) + 2);
        slice[strlen(slice) + 1] = '\0';
        slice[strlen(slice) + 0] = c;
        (*i)++;
    }

    (*i)++;

    LispVal *x = lisp_val_str(slice);
    free(slice);
    return x;
}

void lisp_val_print_str(LispStr input) {
    putchar('"');
    for (unsigned i = 0; i < strlen(input); i++) {
        if (strchr("\a\b\f\n\r\t\v\\\'\"", input[i])) {
            printf("%s", lisp_val_str_escape(input[i]));
        } else {
            putchar(input[i]);
        }
    }
    putchar('"');
}

char lisp_val_str_unescape(char c) {
    switch (c) {
    case 'a':
        return '\a';
    case 'b':
        return '\b';
    case 'f':
        return '\f';
    case 'n':
        return '\n';
    case 'r':
        return '\r';
    case 't':
        return '\t';
    case 'v':
        return '\v';
    case '\\':
        return '\\';
    case '\'':
        return '\'';
    case '\"':
        return '\"';
    default:
        return '\0';
    }
}

char *lisp_val_str_escape(char c) {
    switch (c) {
    case '\a':
        return "\\a";
    case '\b':
        return "\\b";
    case '\f':
        return "\\f";
    case '\n':
        return "\\n";
    case '\r':
        return "\\r";
    case '\t':
        return "\\t";
    case '\v':
        return "\\v";
    case '\\':
        return "\\\\";
    case '\'':
        return "\\\'";
    case '\"':
        return "\\\"";
    default:
        return "";
    }
}

#endif
