//
//  SlideInPresentationAnimator.swift
//  Travel AR Escort
//
//  Created by 张佳乔 on 2023/12/17.
//

import UIKit

class SlideRightToLeftAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to) else {
            return
        }

        let containerView = transitionContext.containerView
        let finalFrame = transitionContext.finalFrame(for: toViewController)

        toViewController.view.frame = finalFrame.offsetBy(dx: containerView.bounds.width, dy: 0)
        containerView.addSubview(toViewController.view)

        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toViewController.view.frame = finalFrame
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}

class SlideLeftToRightAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    // 返回动画的持续时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    

    // 执行 dismiss 动画的核心方法
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // 获取源视图控制器（fromViewController）
        guard let fromViewController = transitionContext.viewController(forKey: .from) else {
            return
        }

        // 获取容器视图，这是过渡动画发生的地方
        let containerView = transitionContext.containerView

        // 设置目标视图控制器的最终框架，在屏幕右侧偏移 containerView 的宽度
        let finalFrame = transitionContext.finalFrame(for: fromViewController)
        var initialFrame = finalFrame
        initialFrame.origin.x += containerView.bounds.width

        // 执行动画，将源视图控制器从当前位置向右滑动并逐渐消失
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            fromViewController.view.frame = initialFrame
        }, completion: { _ in
            // 动画完成后，通知过渡动画已完成
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
