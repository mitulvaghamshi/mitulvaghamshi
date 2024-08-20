#include <errno.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifndef PN_DEF_H
#define PN_DEF_H

#define TRUE 0x1
#define FALSE 0x0

#define E_STR "Received [%i]; Expected [%i]"

#define IGNORED __attribute((unused))

#define REPO_ADD_OP(op, fn) le_op_reg(env, op, fn);

#define OP_MAKE(fn, call, op)                                                  \
    LvVal *(fn)(LeEnv * env, LvVal * val) { return (call)(env, val, op); }

#define LV_ASSERT_EQ(val, l, r) LV_ASSERT(val, l == r, E_STR, l, r);

#define LV_ASSERT_NE(val, l, r) LV_ASSERT(val, l != r, E_STR, l, r);

#define LV_ASSERT_IS(val, l, r)                                                \
    LV_ASSERT(val, l == r, E_STR, lv_type_name(l), lv_type_name(r));

#define LV_ASSERT(v, c, f, ...)                                                \
    if (!(c)) {                                                                \
        LvVal *e = lv_err(f, ##__VA_ARGS__);                                   \
        lv_del(v);                                                             \
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

#ifndef PN_DS_H
#define PN_DS_H

struct LvVal;
struct LeEnv;

typedef struct LvVal LvVal;
typedef struct LeEnv LeEnv;

typedef char *LvStr;

typedef LvVal *(*LvFun)(LeEnv *env, LvVal *val);

typedef enum : unsigned {
    LV_ERR = 0x0,
    LV_NUM = 0x1,
    LV_SYM = 0x2,
    LV_STR = 0x3,
    LV_FUN = 0x4,
    LV_SXP = 0x5,
    LV_QXP = 0x6
} LvType;

struct LeEnv {
    unsigned len;
    LvStr *syms;
    LvVal **vals;
    LeEnv *parent;
};

struct LvVal {
    LvType type;
    double num;
    LvStr err;
    LvStr sym;
    LvStr str;
    LvFun fun;
    LeEnv *env;
    LvVal *args;
    LvVal *body;
    LvVal **cell;
    unsigned len;
};

#endif

#ifdef USE_MPC_LIB
#define USE_MPC 1
#else
#define USE_MPC 0
#endif

#if USE_MPC
#include "mpc/mpc.h"
#endif

#ifndef PN_FN_H
#define PN_FN_H

void lv_print(LvVal *val);
void lv_print_expr(LvVal *val, char open, char close);
char *lv_type_name(int type);

LvVal *lv_num(double x);
LvVal *lv_err(char *f, ...);
LvVal *lv_sym(char *s);
LvVal *lv_str(char *s);
LvVal *lv_fun(LvFun fn);
LvVal *lv_sexpr(void);
LvVal *lv_qexpr(void);

LvVal *lv_lmd(LvVal *args, LvVal *body);
LvVal *lv_add(LvVal *val, LvVal *x);
LvVal *lv_pop(LvVal *val, unsigned i);
LvVal *lv_take(LvVal *val, unsigned i);
LvVal *lv_join(LvVal *val, LvVal *x);
LvVal *lv_copy(LvVal *val);
int lv_cmp(LvVal *x_val, LvVal *y_val);
void lv_del(LvVal *val);

LeEnv *le_new(void);
LeEnv *le_copy(LeEnv *env);
LvVal *le_get(LeEnv *env, LvVal *val);
void le_def(LeEnv *env, LvVal *s_val, LvVal *x_val);
void le_put(LeEnv *env, LvVal *s_val, LvVal *x_val);
void le_del(LeEnv *env);

LvVal *lv_eval(LeEnv *env, LvVal *val);
LvVal *lv_eval_sexpr(LeEnv *env, LvVal *val);

#if USE_MPC
LvVal *lv_read(mpc_ast_t *t);
#else
LvVal *lv_read(char *s, int *i, char end);
#endif

LvVal *lv_call(LeEnv *env, LvVal *f_val, LvVal *val);

void le_ops_repo(LeEnv *env);
void le_op_reg(LeEnv *env, char *op, LvFun fn);

#if USE_MPC
LvVal *op_load(LeEnv *env, LvVal *val);
#else
LvVal *op_load(LeEnv *env, LvVal *val);
#endif

LvVal *op_print(LeEnv *env IGNORED, LvVal *val);
LvVal *op_error(LeEnv *env IGNORED, LvVal *val);

LvVal *op_list(LeEnv *env IGNORED, LvVal *val);
LvVal *op_head(LeEnv *env IGNORED, LvVal *val);
LvVal *op_tail(LeEnv *env IGNORED, LvVal *val);
LvVal *op_join(LeEnv *env IGNORED, LvVal *val);
LvVal *op_eval(LeEnv *env IGNORED, LvVal *val);

LvVal *op_add(LeEnv *env, LvVal *val);
LvVal *op_sub(LeEnv *env, LvVal *val);
LvVal *op_mul(LeEnv *env, LvVal *val);
LvVal *op_div(LeEnv *env, LvVal *val);
LvVal *op_mod(LeEnv *env, LvVal *val);

LvVal *op_not(LeEnv *env, LvVal *val);
LvVal *op_and(LeEnv *env, LvVal *val);
LvVal *op_or(LeEnv *env, LvVal *val);
LvVal *op_xor(LeEnv *env, LvVal *val);

LvVal *op_gt(LeEnv *env, LvVal *val);
LvVal *op_lt(LeEnv *env, LvVal *val);
LvVal *op_ge(LeEnv *env, LvVal *val);
LvVal *op_le(LeEnv *env, LvVal *val);
LvVal *op_eq(LeEnv *env, LvVal *val);
LvVal *op_ne(LeEnv *env, LvVal *val);

LvVal *op_deq(LeEnv *env, LvVal *val);
LvVal *op_dne(LeEnv *env, LvVal *val);
LvVal *op_if(LeEnv *env, LvVal *val);

LvVal *op_def(LeEnv *env, LvVal *val);
LvVal *op_put(LeEnv *env, LvVal *val);
LvVal *op_lmd(LeEnv *env, LvVal *val);

LvVal *ops_cal(LeEnv *env IGNORED, LvVal *val, char *op);
LvVal *ops_btw(LeEnv *env IGNORED, LvVal *val, char *op);
LvVal *ops_ord(LeEnv *env IGNORED, LvVal *val, char *op);
LvVal *ops_equ(LeEnv *env IGNORED, LvVal *val, char *op);
LvVal *ops_cmp(LeEnv *env, LvVal *val, char *op IGNORED);
LvVal *ops_var(LeEnv *env, LvVal *val, char *op);

#if !USE_MPC
LvVal *lv_read_expr(char *s, int *i);
LvVal *lv_read_sym(char *s, int *i);
LvVal *lv_read_str(char *s, int *i);
void lv_print_str(char *val);
char lv_str_unescape(char c);
char *lv_str_escape(char c);
#endif

#endif

#if USE_MPC
#define PARSER_COUNT 8

mpc_parser_t *PN;
#endif

int main(int argc, char **argv) {
    puts("Lisp Version 0.0.1 (q to quit).");

#if USE_MPC
    printf("Using MPC!!!");
    mpc_parser_t *Number = mpc_new("number");   // 1
    mpc_parser_t *Symbol = mpc_new("symbol");   // 2
    mpc_parser_t *String = mpc_new("string");   // 3
    mpc_parser_t *Comment = mpc_new("comment"); // 4
    mpc_parser_t *Sexpr = mpc_new("sexpr");     // 5
    mpc_parser_t *Qexpr = mpc_new("qexpr");     // 6
    mpc_parser_t *Expr = mpc_new("expr");       // 7
    PN = mpc_new("pn");                         // 8

    mpca_lang(MPCA_LANG_DEFAULT, "                          \
        number  : /-?\\d+(\\.\\d+)?/                      ; \
        symbol  : /[a-zA-Z0-9_+\\-*\\/%\\\\=<>!&]+/       ; \
        string  : /\"(\\\\.|[^\"])*\"/                    ; \
        comment : /;[^\\r\\n]*/                           ; \
        sexpr   : '(' <expr>* ')'                         ; \
        qexpr   : '{' <expr>* '}'                         ; \
        expr    : <number> | <symbol> | <string>            \
                | <comment> | <sexpr> | <qexpr>           ; \
        pn      : /^/ <expr>* /$/                         ; ",
              Number, Symbol, String, Comment, Sexpr, Qexpr, Expr, PN);
#endif

    LeEnv *env = le_new();
    le_ops_repo(env);

    if (argc > 1) {
        for (int i = 1; i < argc; i++) {
            LvVal *arg = lv_add(lv_sexpr(), lv_str(argv[i]));
            LvVal *res = op_load(env, arg);
            if (res->type == LV_ERR) {
                lv_print(res);
                putchar('\n');
            }
            lv_del(res);
        }
    }

    while (TRUE) {
        char *buffer = readline("lisp> ");
        if (strcmp(buffer, "q") == 0) {
            free(buffer);
            break;
        }
        add_history(buffer);

#if USE_MPC
        mpc_result_t res;
        if (mpc_parse("<stdin>", buffer, PN, &res)) {
            LvVal *expr = lv_eval(env, lv_read(res.output));
            lv_print(expr);
            putchar('\n');
            lv_del(expr);
            mpc_ast_delete(res.output);
        } else {
            mpc_err_print(res.error);
            mpc_err_delete(res.error);
        }
#else
        int pos = 0;
        LvVal *expr = lv_eval(env, lv_read(buffer, &pos, '\0'));
        lv_print(expr);
        putchar('\n');
        lv_del(expr);
#endif
        free(buffer);
    }

    clear_history();
    le_del(env);
#if USE_MPC
    mpc_cleanup(PARSER_COUNT, Number, Symbol, String, Comment, Sexpr, Qexpr,
                Expr, PN);
#endif

    return 0;
}

void lv_print(LvVal *val) {
    switch (val->type) {
    case LV_NUM: {
        printf("%0.2lf", val->num);
    } break;
    case LV_ERR: {
        printf("%s", val->err);
    } break;
    case LV_SYM: {
        printf("%s", val->sym);
    } break;
    case LV_STR: {
#if USE_MPC
        char *escaped = malloc(strlen(val->str) + 1);
        strcpy(escaped, val->str);
        escaped = mpcf_escape(escaped);
        printf("\"%s\"", escaped);
        free(escaped);
#else
        lv_print_str(val->str);
#endif
    } break;
    case LV_FUN: {
        if (val->fun) {
            printf("<Fn>");
        } else {
            printf("(\\ ");
            lv_print(val->args);
            putchar(' ');
            lv_print(val->body);
            putchar(')');
        }
    } break;
    case LV_SXP: {
        lv_print_expr(val, '(', ')');
    } break;
    case LV_QXP: {
        lv_print_expr(val, '{', '}');
    } break;
    }
}

void lv_print_expr(LvVal *val, char open, char close) {
    putchar(open);
    for (unsigned i = 0; i < val->len; i++) {
        lv_print(val->cell[i]);
        if (i != (val->len - 1)) {
            putchar(' ');
        }
    }
    putchar(close);
}

char *lv_type_name(int type) {
    switch (type) {
    case LV_NUM:
        return "Number";
    case LV_ERR:
        return "Error";
    case LV_SYM:
        return "Symbol";
    case LV_STR:
        return "String";
    case LV_FUN:
        return "Function";
    case LV_SXP:
        return "S-Expression";
    case LV_QXP:
        return "Q-Expression";
    default:
        return "Unknown";
    }
}

LvVal *lv_num(double x) {
    LvVal *val = malloc(sizeof(LvVal));
    val->type = LV_NUM;
    val->num = x;
    return val;
}

LvVal *lv_err(char *f, ...) {
    LvVal *val = malloc(sizeof(LvVal));
    val->type = LV_ERR;
    unsigned buf_size = 1024;
    va_list va;
    va_start(va, f);
    val->err = malloc(buf_size);
    vsnprintf(val->err, buf_size - 1, f, va);
    val->err = realloc(val->err, strlen(val->err) + 1);
    va_end(va);
    return val;
}

LvVal *lv_sym(char *s) {
    LvVal *val = malloc(sizeof(LvVal));
    val->type = LV_SYM;
    val->sym = malloc(strlen(s) + 1);
    strcpy(val->sym, s);
    return val;
}

LvVal *lv_str(char *s) {
    LvVal *val = malloc(sizeof(LvVal));
    val->type = LV_STR;
    val->str = malloc(strlen(s) + 1);
    strcpy(val->str, s);
    return val;
}

LvVal *lv_fun(LvFun fn) {
    LvVal *val = malloc(sizeof(LvVal));
    val->type = LV_FUN;
    val->fun = fn;
    return val;
}

LvVal *lv_sexpr(void) {
    LvVal *val = malloc(sizeof(LvVal));
    val->type = LV_SXP;
    val->len = 0;
    val->cell = NULL;
    return val;
}

LvVal *lv_qexpr(void) {
    LvVal *val = malloc(sizeof(LvVal));
    val->type = LV_QXP;
    val->len = 0;
    val->cell = NULL;
    return val;
}

LvVal *lv_lmd(LvVal *args, LvVal *body) {
    LvVal *val = malloc(sizeof(LvVal));
    val->type = LV_FUN;
    val->fun = NULL;
    val->env = le_new();
    val->args = args;
    val->body = body;
    return val;
}

LvVal *lv_add(LvVal *val, LvVal *x) {
    val->len++;
    val->cell = realloc(val->cell, sizeof(LvVal) * val->len);
    val->cell[val->len - 1] = x;
    return val;
}

LvVal *lv_pop(LvVal *val, unsigned i) {
    LvVal *x = val->cell[i];
    memmove(&val->cell[i], &val->cell[i + 1],
            sizeof(LvVal) * (val->len - i - 1));
    val->len--;
    val->cell = realloc(val->cell, sizeof(LvVal) * val->len);
    return x;
}

LvVal *lv_take(LvVal *val, unsigned i) {
    LvVal *x = lv_pop(val, i);
    lv_del(val);
    return x;
}

LvVal *lv_join(LvVal *val, LvVal *x) {
    for (unsigned i = 0; i < x->len; i++) {
        val = lv_add(val, x->cell[i]);
    }
    free(x->cell);
    free(x);

    return val;
}

LvVal *lv_copy(LvVal *val) {
    LvVal *x = malloc(sizeof(LvVal));
    x->type = val->type;
    switch (val->type) {
    case LV_NUM: {
        x->num = val->num;
    } break;
    case LV_ERR: {
        x->err = malloc(strlen(val->err) + 1);
        strcpy(x->err, val->err);
    } break;
    case LV_SYM: {
        x->sym = malloc(strlen(val->sym) + 1);
        strcpy(x->sym, val->sym);
    } break;
    case LV_STR: {
        x->str = malloc(strlen(val->str) + 1);
        strcpy(x->str, val->str);
    } break;
    case LV_FUN: {
        if (val->fun) {
            x->fun = val->fun;
        } else {
            x->fun = NULL;
            x->env = le_copy(val->env);
            x->args = lv_copy(val->args);
            x->body = lv_copy(val->body);
        }
    } break;
    case LV_SXP:
    case LV_QXP: {
        x->len = val->len;
        x->cell = malloc(sizeof(LvVal) * val->len);
        for (unsigned i = 0; i < x->len; i++) {
            x->cell[i] = lv_copy(val->cell[i]);
        }
    } break;
    }
    return x;
}

int lv_cmp(LvVal *x_val, LvVal *y_val) {
    if (x_val->type != y_val->type) {
        return 0;
    }
    switch (x_val->type) {
    case LV_NUM: {
        return (x_val->num == y_val->num);
    } break;
    case LV_ERR: {
        return (strcmp(x_val->err, y_val->err) == 0);
    } break;
    case LV_SYM: {
        return (strcmp(x_val->sym, y_val->sym) == 0);
    } break;
    case LV_STR: {
        return (strcmp(x_val->str, y_val->str) == 0);
    } break;
    case LV_FUN: {
        if (x_val->fun || y_val->fun) {
            return x_val->fun == y_val->fun;
        }
        return (lv_cmp(x_val->args, y_val->args) &&
                lv_cmp(x_val->body, y_val->body));
    } break;
    case LV_SXP:
    case LV_QXP: {
        if (x_val->len != y_val->len) {
            return 0;
        }
        for (unsigned i = 0; i < x_val->len; i++) {
            if (!lv_cmp(x_val->cell[i], y_val->cell[i])) {
                return 0;
            }
        }
        return 1;
    } break;
    }
    return 0;
}

void lv_del(LvVal *val) {
    switch (val->type) {
    case LV_NUM: {
    } break;
    case LV_ERR: {
        free(val->err);
    } break;
    case LV_SYM: {
        free(val->sym);
    } break;
    case LV_STR: {
        free(val->str);
    } break;
    case LV_FUN: {
        if (!val->fun) {
            le_del(val->env);
            lv_del(val->args);
            lv_del(val->body);
        }
    } break;
    case LV_SXP:
    case LV_QXP: {
        for (unsigned i = 0; i < val->len; i++) {
            lv_del(val->cell[i]);
        }
        free(val->cell);
    } break;
    }
    free(val);
}

LeEnv *le_new(void) {
    LeEnv *env = malloc(sizeof(LeEnv));
    env->len = 0;
    env->syms = NULL;
    env->vals = NULL;
    env->parent = NULL;
    return env;
}

LeEnv *le_copy(LeEnv *env) {
    LeEnv *x = malloc(sizeof(LeEnv));
    x->len = env->len;
    x->parent = env->parent;

    x->syms = malloc(sizeof(char *) * env->len);
    x->vals = malloc(sizeof(LvVal) * env->len);

    for (unsigned i = 0; i < env->len; i++) {
        x->syms[i] = malloc(strlen(env->syms[i]) + 1);
        strcpy(x->syms[i], env->syms[i]);
        x->vals[i] = lv_copy(env->vals[i]);
    }
    return x;
}

LvVal *le_get(LeEnv *env, LvVal *val) {
    for (unsigned i = 0; i < env->len; i++) {
        if (strcmp(env->syms[i], val->sym) == 0) {
            return lv_copy(env->vals[i]);
        }
    }
    return env->parent ? le_get(env->parent, val)
                       : lv_err("Unbound Symbol '%s'", val->sym);
}

void le_def(LeEnv *env, LvVal *s_val, LvVal *x_val) {
    while (env->parent) {
        env = env->parent;
    }
    le_put(env, s_val, x_val);
}

void le_put(LeEnv *env, LvVal *s_val, LvVal *x_val) {
    for (unsigned i = 0; i < env->len; i++) {
        if (strcmp(env->syms[i], s_val->sym) == 0) {
            lv_del(env->vals[i]);
            env->vals[i] = lv_copy(x_val);
            return;
        }
    }

    env->len++;

    env->syms = realloc(env->syms, sizeof(char *) * env->len);
    env->syms[env->len - 1] = malloc(strlen(s_val->sym) + 1);
    strcpy(env->syms[env->len - 1], s_val->sym);

    env->vals = realloc(env->vals, sizeof(LvVal) * env->len);
    env->vals[env->len - 1] = lv_copy(x_val);
}

void le_del(LeEnv *env) {
    for (unsigned i = 0; i < env->len; i++) {
        free(env->syms[i]);
        lv_del(env->vals[i]);
    }
    free(env->syms);
    free(env->vals);
    free(env);
}

LvVal *lv_eval(LeEnv *env, LvVal *val) {
    if (val->type == LV_SYM) {
        LvVal *x = le_get(env, val);
        lv_del(val);
        return x;
    }
    if (val->type == LV_SXP) {
        return lv_eval_sexpr(env, val);
    }
    return val;
}

LvVal *lv_eval_sexpr(LeEnv *env, LvVal *val) {
    for (unsigned i = 0; i < val->len; i++) {
        val->cell[i] = lv_eval(env, val->cell[i]);
    }

    for (unsigned i = 0; i < val->len; i++) {
        if (val->cell[i]->type == LV_ERR) {
            return lv_take(val, i);
        }
    }

    if (val->len == 0) {
        return val;
    } else if (val->len == 1) {
        return lv_eval(env, lv_take(val, 0));
    }

    LvVal *f_val = lv_pop(val, 0);
    if (f_val->type != LV_FUN) {
        LvVal *err =
            lv_err(E_STR, lv_type_name(f_val->type), lv_type_name(LV_FUN));
        lv_del(f_val);
        lv_del(val);
        return err;
    }

    LvVal *res = lv_call(env, f_val, val);
    lv_del(f_val);
    return res;
}

#if USE_MPC
LvVal *lv_read(mpc_ast_t *t) {
    if (strstr(t->tag, "number")) {
        errno = 0;
        double x = strtod(t->contents, NULL);
        if (errno == ERANGE) {
            return lv_err("Result too large!");
        }
        return lv_num(x);
    }

    if (strstr(t->tag, "symbol")) {
        return lv_sym(t->contents);
    }

    if (strstr(t->tag, "string")) {
        t->contents[strlen(t->contents) - 1] = '\0';
        char *unescaped = malloc(strlen(t->contents + 1) + 1);
        strcpy(unescaped, t->contents + 1);
        unescaped = mpcf_unescape(unescaped);
        LvVal *val = lv_str(unescaped);
        free(unescaped);
        return val;
    }

    LvVal *x = NULL;

    if (strcmp(t->tag, ">") == 0 || strstr(t->tag, "sexpr")) {
        x = lv_sexpr();
    } else if (strstr(t->tag, "qexpr")) {
        x = lv_qexpr();
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
        x = lv_add(x, lv_read(t->children[i]));
    }
    return x;
}
#else
LvVal *lv_read(char *s, int *i, char end) {
    LvVal *x = (end == '{') ? lv_qexpr() : lv_sexpr();

    while (s[*i] != end) {
        LvVal *y = lv_read_expr(s, i);
        if (y->type == LV_ERR) {
            lv_del(x);
            return y;
        } else {
            lv_add(x, y);
        }
    }

    (*i)++;

    return x;
}
#endif

LvVal *lv_call(LeEnv *env, LvVal *f_val, LvVal *val) {
    if (f_val->fun) {
        return f_val->fun(env, val);
    }

    while (val->len) {
        LV_ASSERT(val, f_val->args->len != 0, E_STR, val->len,
                  f_val->args->len);

        LvVal *s_val = lv_pop(f_val->args, 0);

        if (strcmp(s_val->sym, "&") == 0) {
            LV_ASSERT_EQ(val, f_val->args->len, 1);

            LvVal *n_sym = lv_pop(f_val->args, 0);
            le_put(f_val->env, n_sym, op_list(env, val));
            lv_del(s_val);
            lv_del(n_sym);
            break;
        }

        LvVal *x_val = lv_pop(val, 0);
        le_put(f_val->env, s_val, x_val);
        lv_del(s_val);
        lv_del(x_val);
    }

    lv_del(val);

    if (f_val->args->len > 0 && strcmp(f_val->args->cell[0]->sym, "&") == 0) {
        LV_ASSERT_EQ(lv_num(0), f_val->args->len, 2);

        lv_del(lv_pop(f_val->args, 0));

        LvVal *n_sym = lv_pop(f_val->args, 0);
        LvVal *q_val = lv_qexpr();

        le_put(f_val->env, n_sym, q_val);
        lv_del(n_sym);
        lv_del(q_val);
    }

    if (f_val->args->len == 0) {
        f_val->env->parent = env;
        return op_eval(f_val->env, lv_add(lv_sexpr(), lv_copy(f_val->body)));
    } else {
        return lv_copy(f_val);
    }
}

void le_ops_repo(LeEnv *env) {
    le_op_reg(env, "load", op_load);
    le_op_reg(env, "print", op_print);
    le_op_reg(env, "error", op_error);

    le_op_reg(env, "list", op_list);
    le_op_reg(env, "head", op_head);
    le_op_reg(env, "tail", op_tail);
    le_op_reg(env, "join", op_join);
    le_op_reg(env, "eval", op_eval);

    le_op_reg(env, "+", op_add);
    le_op_reg(env, "-", op_sub);
    le_op_reg(env, "*", op_mul);
    le_op_reg(env, "/", op_div);
    le_op_reg(env, "%", op_mod);

    le_op_reg(env, "not", op_not);
    le_op_reg(env, "and", op_and);
    le_op_reg(env, "or", op_or);
    le_op_reg(env, "xor", op_xor);

    le_op_reg(env, ">", op_gt);
    le_op_reg(env, "<", op_lt);
    le_op_reg(env, ">=", op_ge);
    le_op_reg(env, "<=", op_le);
    le_op_reg(env, "==", op_eq);
    le_op_reg(env, "!=", op_ne);

    le_op_reg(env, "===", op_deq);
    le_op_reg(env, "!==", op_dne);
    le_op_reg(env, "if", op_if);

    le_op_reg(env, "def", op_def);
    le_op_reg(env, "=", op_put);
    le_op_reg(env, "\\", op_lmd);
}

void le_op_reg(LeEnv *env, char *op, LvFun fn) {
    LvVal *v_sym = lv_sym(op);
    LvVal *v_fun = lv_fun(fn);
    le_put(env, v_sym, v_fun);
    lv_del(v_sym);
    lv_del(v_fun);
}

#if USE_MPC
LvVal *op_load(LeEnv *env, LvVal *val) {
    LV_ASSERT_EQ(val, val->len, 1);
    LV_ASSERT_IS(val, val->cell[0]->type, LV_STR);

    mpc_result_t res;
    if (mpc_parse_contents(val->cell[0]->str, PN, &res)) {
        LvVal *expr = lv_read(res.output);
        mpc_ast_delete(res.output);

        while (expr->len) {
            LvVal *x = lv_eval(env, lv_pop(expr, 0));
            if (x->type == LV_ERR) {
                lv_print(x);
                putchar('\n');
            }
            lv_del(x);
        }

        lv_del(expr);
        lv_del(val);
        return lv_sexpr();
    } else {
        char *e_str = mpc_err_string(res.error);
        mpc_err_delete(res.error);
        LvVal *err = lv_err("Unable to load library %s", e_str);
        free(e_str);
        lv_del(val);
        return err;
    }
}
#else
LvVal *op_load(LeEnv *env, LvVal *val) {
    LV_ASSERT_EQ(val, val->len, 1);
    LV_ASSERT_IS(val, val->cell[0]->type, LV_STR);

    FILE *f = fopen(val->cell[0]->str, "rb");
    if (f == NULL) {
        LvVal *err = lv_err("Unable to load library %s", val->cell[0]->str);
        lv_del(val);
        return err;
    }

    fseek(f, 0, SEEK_END);
    long len = ftell(f);
    fseek(f, 0, SEEK_SET);
    char *buffer = calloc(len + 1, 1);
    fread(buffer, 1, len, f);
    fclose(f);

    int pos = 0;
    LvVal *expr = lv_read(buffer, &pos, '\0');
    free(buffer);

    if (expr->type == LV_ERR) {
        lv_print(expr);
        putchar('\n');
    } else {
        while (expr->len) {
            LvVal *x = lv_eval(env, lv_pop(expr, 0));
            if (x->type == LV_ERR) {
                lv_print(x);
                putchar('\n');
            }
            lv_del(x);
        }
    }

    lv_del(expr);
    lv_del(val);

    return lv_sexpr();
}
#endif

LvVal *op_print(LeEnv *env IGNORED, LvVal *val) {
    for (unsigned i = 0; i < val->len; i++) {
        lv_print(val->cell[i]);
        putchar(' ');
    }
    putchar('\n');
    lv_del(val);
    return lv_sexpr();
}

LvVal *op_error(LeEnv *env IGNORED, LvVal *val) {
    LV_ASSERT_EQ(val, val->len, 1);
    LV_ASSERT_IS(val, val->cell[0]->type, LV_STR);

    LvVal *err = lv_err(val->cell[0]->str);
    lv_del(val);
    return err;
}

LvVal *op_lmd(LeEnv *env, LvVal *val) {
    LV_ASSERT_EQ(val, val->len, 2);
    LV_ASSERT_IS(val, val->cell[0]->type, LV_QXP);
    LV_ASSERT_IS(val, val->cell[1]->type, LV_QXP);

    for (unsigned i = 0; i < val->cell[0]->len; i++) {
        LV_ASSERT_IS(val, val->cell[0]->cell[i]->type, LV_SYM);
    }

    LvVal *args = lv_pop(val, 0);
    LvVal *body = lv_pop(val, 0);
    lv_del(val);
    return lv_lmd(args, body);
}

LvVal *op_list(LeEnv *env IGNORED, LvVal *val) {
    val->type = LV_QXP;
    return val;
}

LvVal *op_head(LeEnv *env IGNORED, LvVal *val) {
    LV_ASSERT_EQ(val, val->len, 1);
    LV_ASSERT_IS(val, val->cell[0]->type, LV_QXP);
    LV_ASSERT_NE(val, val->cell[0]->len, 0);

    LvVal *x = lv_take(val, 0);
    while (x->len > 1) {
        lv_del(lv_pop(x, 1));
    }
    return x;
}

LvVal *op_tail(LeEnv *env IGNORED, LvVal *val) {
    LV_ASSERT_EQ(val, val->len, 1);
    LV_ASSERT_IS(val, val->cell[0]->type, LV_QXP);
    LV_ASSERT_NE(val, val->cell[0]->len, 0);

    LvVal *x = lv_take(val, 0);
    lv_del(lv_pop(x, 0));
    return x;
}

LvVal *op_join(LeEnv *env IGNORED, LvVal *val) {
    for (unsigned i = 0; i < val->len; i++) {
        LV_ASSERT_IS(val, val->cell[i]->type, LV_QXP);
    }

    LvVal *x = lv_pop(val, 0);
    while (val->len) {
        x = lv_join(x, lv_pop(val, 0));
    }
    lv_del(val);
    return x;
}

LvVal *op_eval(LeEnv *env, LvVal *val) {
    LV_ASSERT_EQ(val, val->len, 1);
    LV_ASSERT_IS(val, val->cell[0]->type, LV_QXP);

    LvVal *x = lv_take(val, 0);
    x->type = LV_SXP;
    return lv_eval(env, x);
}

OP_MAKE(op_add, ops_cal, "+");
OP_MAKE(op_sub, ops_cal, "-");
OP_MAKE(op_mul, ops_cal, "*");
OP_MAKE(op_div, ops_cal, "/");
OP_MAKE(op_mod, ops_cal, "%");

OP_MAKE(op_not, ops_btw, "not");
OP_MAKE(op_and, ops_btw, "and");
OP_MAKE(op_or, ops_btw, "or");
OP_MAKE(op_xor, ops_btw, "xor");

OP_MAKE(op_gt, ops_ord, ">");
OP_MAKE(op_lt, ops_ord, "<");
OP_MAKE(op_ge, ops_ord, ">=");
OP_MAKE(op_le, ops_ord, "<=");
OP_MAKE(op_eq, ops_ord, "==");
OP_MAKE(op_ne, ops_ord, "!=");

OP_MAKE(op_deq, ops_equ, "===");
OP_MAKE(op_dne, ops_equ, "!==");
OP_MAKE(op_if, ops_cmp, "if");

OP_MAKE(op_def, ops_var, "def");
OP_MAKE(op_put, ops_var, "=");

LvVal *ops_cal(LeEnv *env IGNORED, LvVal *val, char *op) {
    for (unsigned i = 0; i < val->len; i++) {
        LV_ASSERT_IS(val, val->cell[i]->type, LV_NUM);
    }

    LvVal *x = lv_pop(val, 0);
    if ((strcmp(op, "-") == 0) && val->len == 0) {
        x->num = -x->num;
    }

    while (val->len > 0) {
        LvVal *y = lv_pop(val, 0);
        if (strcmp(op, "+") == 0) {
            x->num += y->num;
        } else if (strcmp(op, "-") == 0) {
            x->num -= y->num;
        } else if (strcmp(op, "*") == 0) {
            x->num *= y->num;
        } else if (y->num == 0) {
            lv_del(x);
            lv_del(y);
            x = lv_err("Infinity!");
            break;
        } else if (strcmp(op, "/") == 0) {
            x->num /= y->num;
        } else if (strcmp(op, "%") == 0) {
            x->num -= ((int)(x->num / y->num) * y->num);
        }
        lv_del(y);
    }

    lv_del(val);
    return x;
}

LvVal *ops_btw(LeEnv *env IGNORED, LvVal *val, char *op) {
    int res = 0;
    if (strcmp(op, "not") == 0) {
        LV_ASSERT_EQ(val, val->len, 1);
        LV_ASSERT_IS(val, val->cell[0]->type, LV_NUM);
        res = ~((int)val->cell[0]->num);
    } else {
        LV_ASSERT_EQ(val, val->len, 2);
        LV_ASSERT_IS(val, val->cell[0]->type, LV_NUM);
        LV_ASSERT_IS(val, val->cell[1]->type, LV_NUM);
        if (strcmp(op, "and") == 0) {
            res = ((int)val->cell[0]->num) & ((int)val->cell[1]->num);
        } else if (strcmp(op, "or") == 0) {
            res = ((int)val->cell[0]->num) | ((int)val->cell[1]->num);
        } else if (strcmp(op, "xor") == 0) {
            res = ((int)val->cell[0]->num) ^ ((int)val->cell[1]->num);
        }
    }

    lv_del(val);
    return lv_num(res);
}

LvVal *ops_ord(LeEnv *env IGNORED, LvVal *val, char *op) {
    LV_ASSERT_EQ(val, val->len, 2);
    LV_ASSERT_IS(val, val->cell[0]->type, LV_NUM);
    LV_ASSERT_IS(val, val->cell[1]->type, LV_NUM);

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

    lv_del(val);
    return lv_num(res);
}

LvVal *ops_equ(LeEnv *env IGNORED, LvVal *val, char *op) {
    LV_ASSERT_EQ(val, val->len, 2);

    int res = -1;
    if (strcmp(op, "===") == 0) {
        res = lv_cmp(val->cell[0], val->cell[1]);
    } else if (strcmp(op, "!==") == 0) {
        res = !lv_cmp(val->cell[0], val->cell[1]);
    }

    lv_del(val);
    return lv_num(res);
}

LvVal *ops_cmp(LeEnv *env, LvVal *val, char *op IGNORED) {
    LV_ASSERT_EQ(val, val->len, 3);
    LV_ASSERT_IS(val, val->cell[0]->type, LV_NUM);
    LV_ASSERT_IS(val, val->cell[1]->type, LV_QXP);
    LV_ASSERT_IS(val, val->cell[2]->type, LV_QXP);

    val->cell[1]->type = LV_SXP;
    val->cell[2]->type = LV_SXP;

    LvVal *res = lv_eval(env, lv_pop(val, (val->cell[0]->num) ? 1 : 2));
    lv_del(val);
    return res;
}

LvVal *ops_var(LeEnv *env, LvVal *val, char *op) {
    LV_ASSERT_IS(val, val->cell[0]->type, LV_QXP);

    LvVal *syms = val->cell[0];
    for (unsigned i = 0; i < syms->len; i++) {
        LV_ASSERT_IS(val, syms->cell[i]->type, LV_SYM);
    }

    LV_ASSERT_EQ(val, syms->len, val->len - 1);

    for (unsigned i = 0; i < syms->len; i++) {
        if (strcmp(op, "def") == 0) {
            le_def(env, syms->cell[i], val->cell[i + 1]);
        }
        if (strcmp(op, "=") == 0) {
            le_put(env, syms->cell[i], val->cell[i + 1]);
        }
    }
    lv_del(val);
    return lv_sexpr();
}

#if !USE_MPC
LvVal *lv_read_expr(char *s, int *i) {
    while (strchr(" \t\v\r\n;", s[*i]) && s[*i] != '\0') {
        if (s[*i] == ';') {
            while (s[*i] != '\n' && s[*i] != '\0') {
                (*i)++;
            }
        }
        (*i)++;
    }

    LvVal *x = NULL;

    if (s[*i] == '\0') {
        return lv_err("Unexpected end of input");
    } else if (s[*i] == '(') {
        (*i)++;
        x = lv_read(s, i, ')');
    } else if (s[*i] == '{') {
        (*i)++;
        x = lv_read(s, i, '}');
    } else if (strchr("abcdefghijklmnopqrstuvwxyz"
                      "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                      "0123456789_+-*\\/=<>!&",
                      s[*i])) {
        x = lv_read_sym(s, i);
    } else if (strchr("\"", s[*i])) {
        x = lv_read_str(s, i);
    } else {
        x = lv_err("Unknown character %c", s[*i]);
    }

    while (strchr(" \t\v\r\n;", s[*i]) && s[*i] != '\0') {
        if (s[*i] == ';') {
            while (s[*i] != '\n' && s[*i] != '\0') {
                (*i)++;
            }
        }
        (*i)++;
    }

    return x;
}

LvVal *lv_read_sym(char *s, int *i) {
    char *slice = calloc(1, 1);
    while (strchr("abcdefghijklmnopqrstuvwxyz"
                  "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                  "0123456789_+-*\\/=<>!&",
                  s[*i]) &&
           s[*i] != '\0') {
        slice = realloc(slice, strlen(slice) + 2);
        slice[strlen(slice) + 1] = '\0';
        slice[strlen(slice) + 0] = s[*i];
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

    LvVal *x = NULL;

    if (is_num) {
        errno = 0;
        double d = strtod(slice, NULL);
        x = (errno != ERANGE) ? lv_num(d) : lv_err("Invalid number %s", slice);
    } else {
        x = lv_sym(slice);
    }

    free(slice);
    return x;
}

LvVal *lv_read_str(char *s, int *i) {
    char *slice = calloc(1, 1);

    (*i)++;
    while (s[*i] != '"') {
        char c = s[*i];

        if (c == '\0') {
            free(slice);
            return lv_err("Unexpected end of input at string literal");
        }

        if (c == '\\') {
            (*i)++;
            if (strchr("abfnrtv\\\'\"", s[*i])) {
                c = lv_str_unescape(s[*i]);
            } else {
                free(slice);
                return lv_err("Invalid escape character \\%c", s[*i]);
            }
        }

        slice = realloc(slice, strlen(slice) + 2);
        slice[strlen(slice) + 1] = '\0';
        slice[strlen(slice) + 0] = c;
        (*i)++;
    }

    LvVal *x = lv_str(slice);
    free(slice);
    return x;
}

void lv_print_str(char *str) {
    putchar('"');
    for (unsigned i = 0; i < strlen(str); i++) {
        if (strchr("\a\b\f\n\r\t\v\\\'\"", str[i])) {
            printf("%s", lv_str_escape(str[i]));
        } else {
            putchar(str[i]);
        }
    }
    putchar('"');
}

char lv_str_unescape(char c) {
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

char *lv_str_escape(char c) {
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
