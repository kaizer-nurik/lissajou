import easygraphics as gr
from math import sin, cos, pi



def prepare(f1,f2,T1,T2):
    res = gr.create_image(1200, 1200)
    gr.set_target(res)
    gr.set_color(gr.color_rgb(40,40,40))    #Рисуем сетку
    gr.set_line_width(1)
    for i in range (24):
        gr.line(0, i*50, 1200, i*50)
        gr.line(i*50, 0, i*50, 1200)

    gr.set_color(gr.Color.BLACK)  # Рисуем оси
    gr.set_line_width(5)
    gr.line(0, 600, 1200, 600)
    gr.line(600, 0, 600, 1200)


    for i in range(400):
        gr.set_color(gr.Color.RED)
        gr.line(i, 600 + f2(i*T1/400), i+1, 600 + f2((i+1)*T1/400))
        gr.set_color(gr.Color.BLUE)
        gr.line(600 + f1(i*T2/400), 1200 - i, 600 + f1((i+1)*T2/400),1199 - i)
    return res


def f1(x):
    return  100*sin(2*x)+100*cos(6*x)

def f2(x):
    return  100*sin(2*x)

def main():
    T1 = 2*pi/2
    T2 = 2*pi/2

    gr.init_graph(1200, 1200)
    gr.set_render_mode(gr.RenderMode.RENDER_MANUAL)
    lis = prepare(f1,f2,T1,T2)
    t1 = 0
    t2 = 0
    step = 0.01



    x1 = f1(t1)
    y1 = f2(t2)

    while gr.is_run():
        if gr.delay_jfps(100):
            t1 += step
            t2 += step

            x2 = f1(t1)
            y2 = f2(t2)

            gr.set_target(lis)
            gr.set_color(gr.Color.GREEN)
            gr.set_line_width(3)
            gr.line(600 + x1, 600 + y1, 600 + x2, 600 + y2)
            gr.set_target()
            gr.clear_device()
            gr.draw_image(0, 0, lis)

            gr.set_line_width(5)
            gr.set_color(gr.Color.GREEN)
            gr.draw_circle(600 + x2, 600 + y2, 5)

            gr.set_color(gr.Color.BLUE)
            gr.set_fill_color(gr.Color.BLUE)
            gr.set_line_width(3)
            gr.line(600, 600, x2 + 600, 600)
            gr.line(600, 600 + y2, x2 + 600, 600 + y2)
            gr.draw_circle(x2 + 600, 600, 5)
            gr.set_line_width(10)
            gr.line(600, 800, x2 + 600, 800)
            gr.draw_circle(x2 + 600, 800, 5)
            gr.draw_circle(x2 + 600, 1200-400 * (t2 % T2)/T2, 5)

            gr.set_color(gr.Color.RED)
            gr.set_fill_color(gr.Color.RED)
            gr.set_line_width(3)
            gr.line(600 + x2, 600, 600 + x2, 600 + y2)
            gr.line(600, 600, 600, 600 + y2)
            gr.draw_circle(600, y2 + 600, 5)
            gr.set_line_width(10)
            gr.line(400, 600, 400, 600 + y2)
            gr.draw_circle(400, 600 + y2, 5)
            gr.draw_circle(400 *  (t1 % T1)/T1, 600+ y2, 5)

            x1 = x2
            y1 = y2

    lis.close()
    gr.close_graph()

gr.easy_run(main)